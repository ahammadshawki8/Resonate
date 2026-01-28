import 'dart:convert';
import 'package:http/http.dart' as http;

class FreesoundService {
  static const String _baseUrl = 'https://freesound.org/apiv2';
  static const String _apiKey = 'OhNlcGzFhZvKB9RAbIGH9fBufn4ikud3b43KCbOR'; // Freesound API key
  
  static FreesoundService? _instance;
  
  FreesoundService._();
  
  static FreesoundService get instance {
    _instance ??= FreesoundService._();
    return _instance!;
  }

  /// Search for sounds by query
  Future<List<FreesoundTrack>> searchSounds({
    required String query,
    int minDuration = 60,
    int maxDuration = 600,
    int pageSize = 5,
  }) async {
    try {
      final uri = Uri.parse('$_baseUrl/search/text/').replace(
        queryParameters: {
          'query': query,
          'filter': 'duration:[$minDuration TO $maxDuration]',
          'fields': 'id,name,username,duration,previews',
          'page_size': pageSize.toString(),
          'token': _apiKey,
        },
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['results'] as List;
        
        return results.map((json) => FreesoundTrack.fromJson(json)).toList();
      } else {
        print('Freesound API error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching sounds: $e');
      return [];
    }
  }

  /// Get specific sound details
  Future<FreesoundTrack?> getSound(int soundId) async {
    try {
      final uri = Uri.parse('$_baseUrl/sounds/$soundId/').replace(
        queryParameters: {
          'fields': 'id,name,username,duration,previews',
          'token': _apiKey,
        },
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return FreesoundTrack.fromJson(data);
      } else {
        print('Freesound API error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching sound: $e');
      return null;
    }
  }

  /// Get curated tracks for each category
  Future<Map<String, List<FreesoundTrack>>> getCuratedTracks() async {
    final categories = {
      'Calm & Peaceful': [
        'ocean waves gentle',
        'rain soft ambient',
        'forest birds morning',
        'piano calm peaceful',
        'stream water flowing',
      ],
      'Uplifting & Happy': [
        'happy upbeat acoustic',
        'cheerful positive melody',
        'joyful uplifting music',
        'optimistic bright tune',
        'feel good happy',
      ],
      'Meditation & Focus': [
        'meditation deep focus',
        'binaural beats focus',
        'zen meditation calm',
        'ambient study concentration',
        'singing bowls meditation',
      ],
      'Energizing': [
        'energetic workout motivation',
        'powerful intense beat',
        'motivational upbeat',
        'victory triumphant',
        'fast paced energetic',
      ],
      'Sleep & Relaxation': [
        'ambient sleep relaxation',
        'peaceful calm night',
        'deep sleep meditation',
        'night crickets peaceful',
        'dreamy ambient sleep',
      ],
    };

    final Map<String, List<FreesoundTrack>> result = {};

    for (final category in categories.entries) {
      final tracks = <FreesoundTrack>[];
      
      for (final query in category.value) {
        final searchResults = await searchSounds(
          query: query,
          pageSize: 1, // Get just one track per query
        );
        
        if (searchResults.isNotEmpty) {
          tracks.add(searchResults.first);
        }
      }
      
      result[category.key] = tracks;
    }

    return result;
  }
}

class FreesoundTrack {
  final int id;
  final String name;
  final String username;
  final double duration;
  final String previewUrl;
  final String? previewHqUrl;

  FreesoundTrack({
    required this.id,
    required this.name,
    required this.username,
    required this.duration,
    required this.previewUrl,
    this.previewHqUrl,
  });

  factory FreesoundTrack.fromJson(Map<String, dynamic> json) {
    final previews = json['previews'] as Map<String, dynamic>;
    
    return FreesoundTrack(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
      duration: (json['duration'] as num).toDouble(),
      previewUrl: previews['preview-lq-mp3'] as String,
      previewHqUrl: previews['preview-hq-mp3'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'duration': duration,
      'previewUrl': previewUrl,
      'previewHqUrl': previewHqUrl,
    };
  }

  String get displayName => name.replaceAll(RegExp(r'[_-]'), ' ');
  
  String get artist => username;
  
  int get durationSeconds => duration.round();
}
