import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

/// Service for handling audio recording functionality.
class AudioService {
  static final AudioRecorder _recorder = AudioRecorder();
  static String? _currentRecordingPath;
  static Timer? _durationTimer;
  static final StreamController<int> _durationController = StreamController<int>.broadcast();
  static int _recordingDuration = 0;

  /// Stream of recording duration in seconds
  static Stream<int> get durationStream => _durationController.stream;

  /// Check if microphone permission is granted
  static Future<bool> hasPermission() async {
    try {
      return await _recorder.hasPermission();
    } catch (e) {
      debugPrint('Error checking permission: $e');
      return false;
    }
  }

  /// Check if currently recording
  static Future<bool> isRecording() async {
    try {
      return await _recorder.isRecording();
    } catch (e) {
      debugPrint('Error checking recording status: $e');
      return false;
    }
  }

  /// Start recording audio
  /// Returns the file path where recording will be saved
  static Future<String?> startRecording() async {
    try {
      // Check permission
      final hasPermission = await AudioService.hasPermission();
      if (!hasPermission) {
        debugPrint('Microphone permission not granted');
        return null;
      }

      // Check if already recording
      if (await isRecording()) {
        debugPrint('Already recording');
        return _currentRecordingPath;
      }

      // Get application documents directory (more reliable than temp on Android)
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String path = '${appDir.path}/recording_$timestamp.m4a';

      debugPrint('Starting recording to path: $path');

      // Start recording
      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc, // AAC format for best compatibility
          bitRate: 128000,
          sampleRate: 44100,
          numChannels: 1, // Mono
        ),
        path: path,
      );

      _currentRecordingPath = path;
      _recordingDuration = 0;

      // Start duration timer
      _durationTimer?.cancel();
      _durationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _recordingDuration++;
        _durationController.add(_recordingDuration);
      });

      debugPrint('Recording started successfully: $path');
      return path;
    } catch (e) {
      debugPrint('Error starting recording: $e');
      debugPrint('Stack trace: ${StackTrace.current}');
      return null;
    }
  }

  /// Stop recording and return the file path
  static Future<String?> stopRecording() async {
    try {
      debugPrint('Stopping recording...');
      debugPrint('Current recording path before stop: $_currentRecordingPath');
      
      // Stop duration timer
      _durationTimer?.cancel();
      _durationTimer = null;

      // Check if we're actually recording
      final isCurrentlyRecording = await _recorder.isRecording();
      debugPrint('Is currently recording: $isCurrentlyRecording');

      // Stop recording
      final path = await _recorder.stop();
      
      debugPrint('Path returned from recorder.stop(): $path');
      
      if (path != null) {
        debugPrint('Recording stopped: $path');
        debugPrint('Duration: $_recordingDuration seconds');
        
        // Verify file exists
        final file = File(path);
        final exists = await file.exists();
        debugPrint('File exists: $exists');
        
        if (exists) {
          final size = await file.length();
          debugPrint('File size: ${size / 1024} KB');
        } else {
          debugPrint('Warning: Recording file does not exist at $path');
        }
      } else {
        debugPrint('Warning: Stop recording returned null path');
        debugPrint('Falling back to stored path: $_currentRecordingPath');
      }

      final recordingPath = path ?? _currentRecordingPath;
      debugPrint('Final recording path: $recordingPath');
      
      _currentRecordingPath = null;
      _recordingDuration = 0;

      return recordingPath;
    } catch (e) {
      debugPrint('Error stopping recording: $e');
      debugPrint('Stack trace: ${StackTrace.current}');
      return null;
    }
  }

  /// Cancel recording and delete the file
  static Future<void> cancelRecording() async {
    try {
      await stopRecording();
      
      if (_currentRecordingPath != null) {
        final file = File(_currentRecordingPath!);
        if (await file.exists()) {
          await file.delete();
          debugPrint('Recording file deleted');
        }
      }
      
      _currentRecordingPath = null;
      _recordingDuration = 0;
    } catch (e) {
      debugPrint('Error canceling recording: $e');
    }
  }

  /// Get current recording duration in seconds
  static int get currentDuration => _recordingDuration;

  /// Dispose resources
  static Future<void> dispose() async {
    _durationTimer?.cancel();
    _durationTimer = null;
    await _durationController.close();
    await _recorder.dispose();
  }
}
