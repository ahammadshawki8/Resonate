import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';

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
  bool _isPlaying = true;
  int _currentTrackIndex = 0;
  double _volume = 0.7;
  int _elapsedSeconds = 0;
  Timer? _timer;
  late AnimationController _visualizerController;
  
  late List<Map<String, dynamic>> _tracks;

  @override
  void initState() {
    super.initState();
    _tracks = _getTracksForCategory(widget.category);
    _startTimer();
    
    _visualizerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  List<Map<String, dynamic>> _getTracksForCategory(String category) {
    switch (category) {
      case 'Calm & Peaceful':
        return [
          {'title': 'Ocean Waves', 'artist': 'Nature Sounds', 'duration': 300, 'icon': Icons.waves},
          {'title': 'Gentle Rain', 'artist': 'Ambient Collection', 'duration': 420, 'icon': Icons.water_drop},
          {'title': 'Forest Morning', 'artist': 'Nature Sounds', 'duration': 360, 'icon': Icons.forest},
          {'title': 'Soft Piano Dreams', 'artist': 'Relaxation Music', 'duration': 280, 'icon': Icons.piano},
          {'title': 'Peaceful Stream', 'artist': 'Nature Sounds', 'duration': 340, 'icon': Icons.water},
        ];
      case 'Uplifting & Happy':
        return [
          {'title': 'Sunshine Melody', 'artist': 'Feel Good Tunes', 'duration': 210, 'icon': Icons.wb_sunny},
          {'title': 'Happy Morning', 'artist': 'Positive Vibes', 'duration': 240, 'icon': Icons.mood},
          {'title': 'Dancing Light', 'artist': 'Joy Collection', 'duration': 200, 'icon': Icons.music_note},
          {'title': 'Cheerful Day', 'artist': 'Feel Good Tunes', 'duration': 225, 'icon': Icons.celebration},
          {'title': 'Smile', 'artist': 'Positive Vibes', 'duration': 195, 'icon': Icons.sentiment_satisfied_alt},
        ];
      case 'Meditation & Focus':
        return [
          {'title': 'Deep Focus', 'artist': 'Concentration Music', 'duration': 600, 'icon': Icons.psychology},
          {'title': 'Binaural Beats 40Hz', 'artist': 'Brain Waves', 'duration': 900, 'icon': Icons.graphic_eq},
          {'title': 'Zen Garden', 'artist': 'Meditation Music', 'duration': 480, 'icon': Icons.spa},
          {'title': 'Lo-Fi Study', 'artist': 'Focus Beats', 'duration': 720, 'icon': Icons.headphones},
          {'title': 'Tibetan Bowls', 'artist': 'Meditation Music', 'duration': 540, 'icon': Icons.self_improvement},
        ];
      case 'Energizing':
        return [
          {'title': 'Power Up', 'artist': 'Workout Beats', 'duration': 180, 'icon': Icons.flash_on},
          {'title': 'Unstoppable', 'artist': 'Motivation Mix', 'duration': 195, 'icon': Icons.fitness_center},
          {'title': 'Rise & Grind', 'artist': 'Energy Boost', 'duration': 210, 'icon': Icons.trending_up},
          {'title': 'Champion', 'artist': 'Workout Beats', 'duration': 200, 'icon': Icons.emoji_events},
          {'title': 'Full Speed', 'artist': 'Motivation Mix', 'duration': 185, 'icon': Icons.speed},
        ];
      default:
        return [
          {'title': 'Ambient Soundscape', 'artist': 'Various', 'duration': 300, 'icon': Icons.music_note},
          {'title': 'Peaceful Moments', 'artist': 'Relaxation', 'duration': 360, 'icon': Icons.spa},
        ];
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isPlaying) {
        setState(() {
          _elapsedSeconds++;
          if (_elapsedSeconds >= (_tracks[_currentTrackIndex]['duration'] as int)) {
            _nextTrack();
          }
        });
      }
    });
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _nextTrack() {
    setState(() {
      _currentTrackIndex = (_currentTrackIndex + 1) % _tracks.length;
      _elapsedSeconds = 0;
    });
  }

  void _previousTrack() {
    setState(() {
      if (_elapsedSeconds > 3) {
        _elapsedSeconds = 0;
      } else {
        _currentTrackIndex = (_currentTrackIndex - 1 + _tracks.length) % _tracks.length;
        _elapsedSeconds = 0;
      }
    });
  }

  void _selectTrack(int index) {
    setState(() {
      _currentTrackIndex = index;
      _elapsedSeconds = 0;
      _isPlaying = true;
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString()}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _visualizerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentTrack = _tracks[_currentTrackIndex];
    final trackDuration = currentTrack['duration'] as int;
    final progress = _elapsedSeconds / trackDuration;

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
                              currentTrack['icon'] as IconData,
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
                    currentTrack['title'] as String,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    currentTrack['artist'] as String,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: isDark ? Colors.white60 : AppColors.textSecondary,
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
                      onChanged: (value) {
                        setState(() {
                          _elapsedSeconds = (value * trackDuration).toInt();
                        });
                      },
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
                          _formatTime(_elapsedSeconds),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: isDark ? Colors.white60 : AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          _formatTime(trackDuration),
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
                        onChanged: (value) {
                          setState(() {
                            _volume = value;
                          });
                        },
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
                          track['icon'] as IconData,
                          color: isCurrentTrack ? Colors.white : widget.color,
                          size: 22.sp,
                        ),
                      ),
                      title: Text(
                        track['title'] as String,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: isCurrentTrack ? FontWeight.bold : FontWeight.normal,
                          color: isCurrentTrack 
                              ? widget.color 
                              : (isDark ? Colors.white : AppColors.textPrimary),
                        ),
                      ),
                      subtitle: Text(
                        track['artist'] as String,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: isDark ? Colors.white38 : AppColors.textSecondary,
                        ),
                      ),
                      trailing: isCurrentTrack && _isPlaying
                          ? Icon(Icons.equalizer, color: widget.color, size: 22.sp)
                              .animate(onPlay: (c) => c.repeat())
                              .shimmer(duration: 1000.ms, color: widget.color)
                          : Text(
                              _formatTime(track['duration'] as int),
                              style: TextStyle(
                                fontSize: 13.sp,
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
