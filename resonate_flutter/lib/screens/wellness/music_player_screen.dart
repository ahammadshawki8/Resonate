import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:just_audio/just_audio.dart';
import '../../core/theme/app_colors.dart';
import '../../core/services/freesound_service.dart';

class MusicPlayerScreen extends StatefulWidget {
  final String category;
  final String emoji;
  final Color color;

  const MusicPlayerScreen({
    super.key,
    required this.category,
    required this.emoji,
    required this.color,
  });

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FreesoundService _freesoundService = FreesoundService.instance;
  
  bool _isPlaying = false;
  bool _isLoading = true;
  String? _errorMessage;
  int _currentTrackIndex = 0;
  double _volume = 0.7;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  late AnimationController _visualizerController;
  
  List<FreesoundTrack> _tracks = [];

  @override
  void initState() {
    super.initState();
    _visualizerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
    
    _initAudioPlayer();
    _loadTracks();
  }

  void _initAudioPlayer() {
    _audioPlayer.setVolume(_volume);
    
    _audioPlayer.positionStream.listen((position) {
      if (mounted) {
        setState(() {
          _position = position;
        });
      }
    });
    
    _audioPlayer.durationStream.listen((duration) {
      if (mounted && duration != null) {
        setState(() {
          _duration = duration;
        });
      }
    });
    
    _audioPlayer.playerStateStream.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state.playing;
        });
        
        if (state.processingState == ProcessingState.completed) {
          _nextTrack();
        }
      }
    });
  }

  Future<void> _loadTracks() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final allTracks = await _freesoundService.getCuratedTracks();
      final categoryTracks = allTracks[widget.category] ?? [];
      
      if (categoryTracks.isEmpty) {
        setState(() {
          _errorMessage = 'No tracks found for this category';
          _isLoading = false;
        });
        return;
      }

      setState(() {
        _tracks = categoryTracks;
        _isLoading = false;
      });

      if (_tracks.isNotEmpty) {
        await _playTrack(0);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load tracks: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _playTrack(int index) async {
    if (index < 0 || index >= _tracks.length) return;

    try {
      setState(() {
        _currentTrackIndex = index;
      });

      final track = _tracks[index];
      final url = track.previewHqUrl ?? track.previewUrl;
      
      await _audioPlayer.setUrl(url);
      await _audioPlayer.play();
    } catch (e) {
      print('Error playing track: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to play track: $e')),
      );
    }
  }

  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'Calm & Peaceful':
        return Icons.waves;
      case 'Uplifting & Happy':
        return Icons.wb_sunny;
      case 'Meditation & Focus':
        return Icons.self_improvement;
      case 'Energizing':
        return Icons.flash_on;
      case 'Sleep & Relaxation':
        return Icons.nightlight;
      default:
        return Icons.music_note;
    }
  }

  Future<void> _togglePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
  }

  Future<void> _nextTrack() async {
    final nextIndex = (_currentTrackIndex + 1) % _tracks.length;
    await _playTrack(nextIndex);
  }

  Future<void> _previousTrack() async {
    if (_position.inSeconds > 3) {
      await _audioPlayer.seek(Duration.zero);
    } else {
      final prevIndex = (_currentTrackIndex - 1 + _tracks.length) % _tracks.length;
      await _playTrack(prevIndex);
    }
  }

  Future<void> _selectTrack(int index) async {
    await _playTrack(index);
  }

  Future<void> _seekTo(double value) async {
    final position = Duration(seconds: (value * _duration.inSeconds).toInt());
    await _audioPlayer.seek(position);
  }

  Future<void> _setVolume(double value) async {
    setState(() {
      _volume = value;
    });
    await _audioPlayer.setVolume(value);
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString()}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _visualizerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    if (_isLoading) {
      return Scaffold(
        backgroundColor: isDark ? const Color(0xFF0f0f1a) : widget.color.withOpacity(0.05),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: widget.color),
              SizedBox(height: 16.h),
              Text(
                'Loading tracks...',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: isDark ? Colors.white70 : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        backgroundColor: isDark ? const Color(0xFF0f0f1a) : widget.color.withOpacity(0.05),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(32.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64.sp, color: Colors.red),
                SizedBox(height: 16.h),
                Text(
                  _errorMessage!,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: isDark ? Colors.white70 : AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: _loadTracks,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.color,
                    padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                  ),
                  child: Text('Retry', style: TextStyle(fontSize: 16.sp)),
                ),
                SizedBox(height: 16.h),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Go Back', style: TextStyle(fontSize: 14.sp, color: widget.color)),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_tracks.isEmpty) {
      return Scaffold(
        backgroundColor: isDark ? const Color(0xFF0f0f1a) : widget.color.withOpacity(0.05),
        body: Center(
          child: Text(
            'No tracks available',
            style: TextStyle(
              fontSize: 16.sp,
              color: isDark ? Colors.white70 : AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    final currentTrack = _tracks[_currentTrackIndex];
    final progress = _duration.inSeconds > 0 ? _position.inSeconds / _duration.inSeconds : 0.0;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: isDark ? const Color(0xFF0f0f1a) : widget.color.withOpacity(0.05),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white.withOpacity(0.1) : Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(Icons.keyboard_arrow_down, size: 28.sp, color: isDark ? Colors.white : AppColors.textPrimary),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'NOW PLAYING',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 2,
                              color: isDark ? Colors.white38 : AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            widget.category,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _scaffoldKey.currentState?.openEndDrawer(),
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white.withOpacity(0.1) : Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(Icons.queue_music, size: 24.sp, color: isDark ? Colors.white : AppColors.textPrimary),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24.h),
            
            // Album Art / Visualizer
            Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  width: 280.w,
                  height: 280.w,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        widget.color.withOpacity(0.3),
                        widget.color.withOpacity(0.1),
                        Colors.transparent,
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer ring
                      Container(
                        width: 260.w,
                        height: 260.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: widget.color.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                      ).animate(
                        target: _isPlaying ? 1 : 0,
                        onPlay: (c) => c.repeat(),
                      ).rotate(duration: 20.seconds),
                      
                      // Inner circle
                      Container(
                        width: 200.w,
                        height: 200.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              widget.color.withOpacity(0.8),
                              widget.color,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: widget.color.withOpacity(0.4),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.emoji,
                              style: TextStyle(fontSize: 48.sp),
                            ),
                            SizedBox(height: 8.h),
                            Icon(
                              _getIconForCategory(widget.category),
                              color: Colors.white,
                              size: 32.sp,
                            ),
                          ],
                        ),
                      ).animate(
                        target: _isPlaying ? 1 : 0,
                        onPlay: (c) => c.repeat(reverse: true),
                      ).scale(
                        begin: const Offset(1, 1),
                        end: const Offset(1.05, 1.05),
                        duration: 1000.ms,
                      ),
                      
                      // Visualizer bars
                      if (_isPlaying) ...[
                        for (int i = 0; i < 12; i++)
                          Positioned(
                            child: Transform.rotate(
                              angle: (i * 30) * 3.14159 / 180,
                              child: AnimatedBuilder(
                                animation: _visualizerController,
                                builder: (context, child) {
                                  final height = 20.h + (_visualizerController.value * 15.h * ((i % 3) + 1));
                                  return Container(
                                    width: 4.w,
                                    height: height,
                                    margin: EdgeInsets.only(bottom: 260.w),
                                    decoration: BoxDecoration(
                                      color: widget.color.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(2.r),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            
            // Track Info
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                children: [
                  Text(
                    currentTrack.displayName,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'by ${currentTrack.artist}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: isDark ? Colors.white60 : AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'via Freesound.org',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: isDark ? Colors.white38 : AppColors.textSecondary.withOpacity(0.6),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 32.h),
            
            // Progress Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Column(
                children: [
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 4.h,
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.r),
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 14.r),
                    ),
                    child: Slider(
                      value: progress.clamp(0.0, 1.0),
                      onChanged: (value) => _seekTo(value),
                      activeColor: widget.color,
                      inactiveColor: widget.color.withOpacity(0.2),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(_position),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: isDark ? Colors.white60 : AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          _formatDuration(_duration),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: isDark ? Colors.white60 : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24.h),
            
            // Controls
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      // Shuffle
                    },
                    icon: Icon(
                      Icons.shuffle,
                      color: isDark ? Colors.white38 : AppColors.textSecondary,
                      size: 24.sp,
                    ),
                  ),
                  IconButton(
                    onPressed: _previousTrack,
                    icon: Icon(
                      Icons.skip_previous,
                      color: isDark ? Colors.white : AppColors.textPrimary,
                      size: 36.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: _togglePlayPause,
                    child: Container(
                      width: 72.w,
                      height: 72.w,
                      decoration: BoxDecoration(
                        color: widget.color,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: widget.color.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 36.sp,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _nextTrack,
                    icon: Icon(
                      Icons.skip_next,
                      color: isDark ? Colors.white : AppColors.textPrimary,
                      size: 36.sp,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Repeat
                    },
                    icon: Icon(
                      Icons.repeat,
                      color: isDark ? Colors.white38 : AppColors.textSecondary,
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24.h),
            
            // Volume
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.w),
              child: Row(
                children: [
                  Icon(Icons.volume_down, color: isDark ? Colors.white38 : AppColors.textSecondary, size: 20.sp),
                  Expanded(
                    child: SliderTheme(
                      data: SliderThemeData(
                        trackHeight: 3.h,
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5.r),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 12.r),
                      ),
                      child: Slider(
                        value: _volume,
                        onChanged: (value) => _setVolume(value),
                        activeColor: widget.color,
                        inactiveColor: widget.color.withOpacity(0.2),
                      ),
                    ),
                  ),
                  Icon(Icons.volume_up, color: isDark ? Colors.white38 : AppColors.textSecondary, size: 20.sp),
                ],
              ),
            ),
            
            SizedBox(height: 48.h),
          ],
        ),
      ),
      endDrawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.75,
        backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: widget.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(Icons.queue_music, color: widget.color, size: 24.sp),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Up Next',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          '${_tracks.length} tracks',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: isDark ? Colors.white60 : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.close,
                        color: isDark ? Colors.white60 : AppColors.textSecondary,
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(color: isDark ? Colors.white12 : Colors.black12),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  itemCount: _tracks.length,
                  itemBuilder: (context, index) {
                    final track = _tracks[index];
                    final isCurrentTrack = index == _currentTrackIndex;
                    return ListTile(
                      onTap: () {
                        _selectTrack(index);
                        Navigator.pop(context);
                      },
                      leading: Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: isCurrentTrack ? widget.color : widget.color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          _getIconForCategory(widget.category),
                          color: isCurrentTrack ? Colors.white : widget.color,
                          size: 22.sp,
                        ),
                      ),
                      title: Text(
                        track.displayName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: isCurrentTrack ? FontWeight.bold : FontWeight.normal,
                          color: isCurrentTrack 
                              ? widget.color 
                              : (isDark ? Colors.white : AppColors.textPrimary),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        track.artist,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: isDark ? Colors.white38 : AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: isCurrentTrack && _isPlaying
                          ? Icon(Icons.equalizer, color: widget.color, size: 22.sp)
                              .animate(onPlay: (c) => c.repeat())
                              .shimmer(duration: 1000.ms, color: widget.color)
                          : Text(
                              _formatDuration(Duration(seconds: track.durationSeconds)),
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: isDark ? Colors.white38 : AppColors.textSecondary,
                              ),
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
