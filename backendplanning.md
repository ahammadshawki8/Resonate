# Resonate Backend Planning Document

## Overview

This document outlines the comprehensive backend development plan for **Resonate** - an emotional wellness application that analyzes voice recordings to detect mood and emotions. The backend will be built using:

1. **Serverpod** (Dart) - Main application server for Flutter client communication
2. **Flask** (Python) - AI/ML service for voice analysis and emotion detection

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         RESONATE ARCHITECTURE                            │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  ┌──────────────┐     ┌──────────────┐     ┌──────────────────────────┐ │
│  │   Flutter    │────▶│  Serverpod   │────▶│      PostgreSQL         │ │
│  │   Client     │◀────│    Server    │◀────│       Database          │ │
│  └──────────────┘     └──────┬───────┘     └──────────────────────────┘ │
│                              │                                           │
│                              │ REST/gRPC                                 │
│                              ▼                                           │
│                       ┌──────────────┐                                   │
│                       │    Flask     │                                   │
│                       │  AI Service  │                                   │
│                       └──────┬───────┘                                   │
│                              │                                           │
│            ┌─────────────────┼─────────────────┐                        │
│            ▼                 ▼                 ▼                        │
│     ┌────────────┐   ┌────────────────┐  ┌─────────────┐               │
│     │  librosa   │   │ Whisper/STT    │  │  LLM API    │               │
│     │  (Audio)   │   │ (Transcribe)   │  │ (Insights)  │               │
│     └────────────┘   └────────────────┘  └─────────────┘               │
│                                                                          │
│  ┌──────────────────────────────────────────────────────────────────┐   │
│  │                        Cloud Storage                              │   │
│  │              (Audio files, User data backups)                     │   │
│  └──────────────────────────────────────────────────────────────────┘   │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

---

# PHASE 1: Serverpod Setup & Core Infrastructure
**Estimated Time: 1-2 weeks**

## Task 1.1: Initialize Serverpod Project
- [ ] Create new Serverpod project with `serverpod create resonate_server`
- [ ] Configure project structure for modules
- [ ] Set up development, staging, and production configurations
- [ ] Configure Docker containers for local development

## Task 1.2: Database Setup
- [ ] Design and create PostgreSQL database schema
- [ ] Set up database migrations system
- [ ] Configure connection pooling
- [ ] Set up database backups strategy

## Task 1.3: Authentication System
- [ ] Implement email/password authentication
- [ ] Set up JWT token management with refresh tokens
- [ ] Implement password hashing (bcrypt)
- [ ] Create password reset flow with email verification
- [ ] Implement OAuth providers (Google, Apple Sign-In)
- [ ] Set up rate limiting for auth endpoints
- [ ] Implement session management

## Task 1.4: Core Data Models
Create Serverpod protocol files for:

```yaml
# models/user.spy.yaml
class: User
table: users
fields:
  email: String
  passwordHash: String
  name: String
  avatarUrl: String?
  createdAt: DateTime
  lastLoginAt: DateTime?
  totalCheckins: int
  currentStreak: int
  averageMood: double
  isEmailVerified: bool

# models/voice_entry.spy.yaml
class: VoiceEntry
table: voice_entries
fields:
  userId: int, relation(parent=users)
  recordedAt: DateTime
  language: String
  audioUrl: String?
  durationSeconds: double
  pitchMean: double
  pitchStd: double
  energyMean: double
  tempo: double
  silenceRatio: double
  transcript: String?
  emotionKeywords: List<String>?
  sentimentScore: double?
  detectedEmotions: List<String>?
  topicContext: String?
  acousticMoodScore: double
  semanticMoodScore: double?
  finalMoodScore: double
  moodLabel: String
  confidence: double
  signalAlignment: double?
  note: String?
  privacyLevel: String

# models/insight.spy.yaml
class: Insight
table: insights
fields:
  userId: int, relation(parent=users)
  insightText: String
  insightType: String
  generatedAt: DateTime
  isRead: bool

# models/tag.spy.yaml
class: Tag
table: tags
fields:
  userId: int, relation(parent=users)
  name: String
  color: String
  usageCount: int

# models/user_settings.spy.yaml
class: UserSettings
table: user_settings
fields:
  userId: int, relation(parent=users), unique
  reminderHour: int
  reminderMinute: int
  reminderEnabled: bool
  darkMode: bool
  uiLanguage: String
  voiceLanguage: String
  privacyLevel: String
  notificationsEnabled: bool

# models/journal_entry.spy.yaml
class: JournalEntry
table: journal_entries
fields:
  userId: int, relation(parent=users)
  createdAt: DateTime
  content: String
  prompt: String
  moodAtTime: String?

# models/gratitude_entry.spy.yaml
class: GratitudeEntry
table: gratitude_entries
fields:
  userId: int, relation(parent=users)
  createdAt: DateTime
  items: List<String>

# models/wellness_goal.spy.yaml
class: WellnessGoal
table: wellness_goals
fields:
  userId: int, relation(parent=users)
  createdAt: DateTime
  title: String
  emoji: String
  isCompleted: bool
  completedAt: DateTime?

# models/favorite_contact.spy.yaml
class: FavoriteContact
table: favorite_contacts
fields:
  userId: int, relation(parent=users)
  createdAt: DateTime
  name: String
  emoji: String
  type: String
  phone: String?

# models/mood_pattern.spy.yaml
class: MoodPattern
table: mood_patterns
fields:
  userId: int, relation(parent=users)
  patternType: String
  description: String
  confidence: double
  detectedAt: DateTime
```

## Task 1.5: File Storage Setup
- [ ] Configure cloud storage (AWS S3 / Google Cloud Storage / Azure Blob)
- [ ] Set up audio file upload endpoints
- [ ] Implement secure signed URLs for audio access
- [ ] Set up file retention policies (user-configurable)
- [ ] Implement audio file encryption at rest

---

# PHASE 2: Flask AI/ML Service
**Estimated Time: 2-3 weeks**

## Task 2.1: Flask Project Setup
- [ ] Initialize Flask project with proper structure
- [ ] Set up virtual environment and requirements.txt
- [ ] Configure Flask for production (gunicorn/uvicorn)
- [ ] Set up logging and error handling
- [ ] Configure CORS for Serverpod communication
- [ ] Set up health check endpoints

## Task 2.2: Audio Processing Pipeline
### Acoustic Feature Extraction (librosa)
- [ ] Implement audio preprocessing (normalization, noise reduction)
- [ ] Extract fundamental frequency (F0/pitch) features
  - Mean, standard deviation, range
  - Pitch contour patterns
- [ ] Extract energy/intensity features
  - RMS energy
  - Energy variability
- [ ] Extract temporal features
  - Speech rate (tempo)
  - Pause patterns
  - Silence ratio
- [ ] Extract spectral features (MFCCs)
- [ ] Implement voice activity detection (VAD)

### Acoustic Mood Scoring Algorithm
```python
# Pseudo-implementation
def calculate_acoustic_mood(features):
    """
    Score based on research correlations:
    - Higher pitch variability → more emotional expressiveness
    - Higher energy → more positive/energetic
    - Faster tempo with energy → excitement/happiness
    - Slower tempo with lower energy → sadness/tiredness
    - Long pauses → hesitation, anxiety, or sadness
    """
    score = 0.5  # neutral baseline
    
    # Pitch analysis
    score += pitch_variability_factor(features['pitch_std'])
    
    # Energy analysis
    score += energy_factor(features['energy_mean'])
    
    # Tempo and rhythm
    score += tempo_factor(features['tempo'], features['silence_ratio'])
    
    # Clamp to [0, 1]
    return max(0.0, min(1.0, score))
```

## Task 2.3: Speech-to-Text Integration
- [ ] Integrate OpenAI Whisper (local or API)
  - Support for multiple languages (English, Bengali)
  - Implement language detection
- [ ] Alternative: Google Cloud Speech-to-Text
- [ ] Implement transcript post-processing
  - Punctuation restoration
  - Profanity filtering (optional)
- [ ] Handle transcription errors gracefully

## Task 2.4: Semantic/NLP Analysis
- [ ] Sentiment Analysis
  - Integrate transformer-based model (e.g., RoBERTa, BERT)
  - Fine-tune for emotional language
  - Calculate sentiment polarity and intensity
- [ ] Emotion Detection from Text
  - Multi-label emotion classification
  - Detect: joy, sadness, anger, fear, surprise, disgust, neutral
  - Extract emotion keywords
- [ ] Topic/Context Detection
  - Classify into categories: work, family, health, social, etc.
- [ ] Calculate semantic mood score from NLP results

## Task 2.5: Multi-Modal Fusion
- [ ] Implement signal alignment checking
  - Compare acoustic vs semantic signals
  - Detect incongruence (e.g., sad words with happy tone)
- [ ] Weighted fusion algorithm for final mood score
  ```python
  def calculate_final_mood(acoustic_score, semantic_score, privacy_level):
      if privacy_level == 'acoustic':
          return acoustic_score
      elif privacy_level == 'keywords':
          return 0.7 * acoustic_score + 0.3 * semantic_score
      elif privacy_level == 'context':
          return 0.5 * acoustic_score + 0.5 * semantic_score
      else:  # 'full'
          alignment = calculate_alignment(acoustic_score, semantic_score)
          return weighted_average(acoustic_score, semantic_score, alignment)
  ```
- [ ] Confidence score calculation

## Task 2.6: Flask API Endpoints
```python
# POST /api/v1/analyze
# Request: multipart/form-data with audio file
# Response:
{
    "acoustic_features": {
        "pitch_mean": 145.2,
        "pitch_std": 23.5,
        "energy_mean": 0.072,
        "tempo": 118.5,
        "silence_ratio": 0.15
    },
    "transcript": "I had a really good day today...",
    "sentiment_score": 0.65,
    "detected_emotions": ["happy", "hopeful"],
    "emotion_keywords": ["good", "excited", "looking forward"],
    "topic_context": "work",
    "acoustic_mood_score": 0.72,
    "semantic_mood_score": 0.68,
    "final_mood_score": 0.70,
    "mood_label": "positive",
    "confidence": 0.87,
    "signal_alignment": 0.92,
    "language": "en"
}

# POST /api/v1/generate-insight
# Request: user mood history
# Response: personalized insight text

# GET /api/v1/health
# Health check endpoint
```

## Task 2.7: Privacy-Compliant Processing
- [ ] Implement privacy level handling
  - `full`: Full analysis with transcript storage
  - `context`: Temp transcription, no storage
  - `keywords`: Only emotion keywords extracted
  - `acoustic`: No speech recognition
- [ ] Secure audio processing (no logging of content)
- [ ] Implement data deletion on request

---

# PHASE 3: Serverpod API Endpoints
**Estimated Time: 1-2 weeks**

## Task 3.1: User Endpoints
```dart
// user_endpoint.dart
class UserEndpoint extends Endpoint {
  // GET /user/profile
  Future<User> getProfile(Session session);
  
  // PUT /user/profile
  Future<User> updateProfile(Session session, UserUpdate update);
  
  // DELETE /user/account
  Future<void> deleteAccount(Session session);
  
  // GET /user/stats
  Future<UserStats> getStats(Session session);
}
```

## Task 3.2: Voice Entry Endpoints
```dart
// voice_entry_endpoint.dart
class VoiceEntryEndpoint extends Endpoint {
  // POST /entries/upload
  Future<VoiceEntry> uploadAndAnalyze(
    Session session, 
    ByteData audioData, 
    String language,
    String privacyLevel,
  );
  
  // GET /entries
  Future<List<VoiceEntry>> getEntries(
    Session session, 
    {DateTime? startDate, DateTime? endDate, int? limit}
  );
  
  // GET /entries/:id
  Future<VoiceEntry?> getEntry(Session session, int id);
  
  // PUT /entries/:id
  Future<VoiceEntry> updateEntry(Session session, int id, VoiceEntryUpdate update);
  
  // DELETE /entries/:id
  Future<void> deleteEntry(Session session, int id);
  
  // GET /entries/today
  Future<VoiceEntry?> getTodayEntry(Session session);
  
  // GET /entries/week
  Future<List<VoiceEntry>> getWeekEntries(Session session);
  
  // GET /entries/calendar/:year/:month
  Future<Map<int, VoiceEntry>> getCalendarEntries(Session session, int year, int month);
}
```

## Task 3.3: Insights Endpoints
```dart
// insight_endpoint.dart
class InsightEndpoint extends Endpoint {
  // GET /insights
  Future<List<Insight>> getInsights(Session session, {int? limit});
  
  // PUT /insights/:id/read
  Future<void> markAsRead(Session session, int id);
  
  // PUT /insights/read-all
  Future<void> markAllAsRead(Session session);
  
  // POST /insights/generate
  Future<Insight> generateInsight(Session session);
}
```

## Task 3.4: Settings Endpoints
```dart
// settings_endpoint.dart
class SettingsEndpoint extends Endpoint {
  // GET /settings
  Future<UserSettings> getSettings(Session session);
  
  // PUT /settings
  Future<UserSettings> updateSettings(Session session, UserSettings settings);
}
```

## Task 3.5: Tags Endpoints
```dart
// tag_endpoint.dart
class TagEndpoint extends Endpoint {
  // GET /tags
  Future<List<Tag>> getTags(Session session);
  
  // POST /tags
  Future<Tag> createTag(Session session, Tag tag);
  
  // DELETE /tags/:id
  Future<void> deleteTag(Session session, int id);
}
```

## Task 3.6: Wellness Features Endpoints
```dart
// wellness_endpoint.dart
class WellnessEndpoint extends Endpoint {
  // Journals
  Future<List<JournalEntry>> getJournals(Session session);
  Future<JournalEntry> createJournal(Session session, JournalEntry entry);
  Future<void> deleteJournal(Session session, int id);
  
  // Gratitude
  Future<List<GratitudeEntry>> getGratitudeEntries(Session session);
  Future<GratitudeEntry> createGratitude(Session session, GratitudeEntry entry);
  Future<void> deleteGratitude(Session session, int id);
  
  // Goals
  Future<List<WellnessGoal>> getGoals(Session session);
  Future<WellnessGoal> createGoal(Session session, WellnessGoal goal);
  Future<WellnessGoal> toggleGoal(Session session, int id);
  Future<void> deleteGoal(Session session, int id);
  
  // Contacts
  Future<List<FavoriteContact>> getContacts(Session session);
  Future<FavoriteContact> createContact(Session session, FavoriteContact contact);
  Future<void> deleteContact(Session session, int id);
}
```

## Task 3.7: Analytics/Trends Endpoints
```dart
// analytics_endpoint.dart
class AnalyticsEndpoint extends Endpoint {
  // GET /analytics/weekly
  Future<WeeklyAnalytics> getWeeklyAnalytics(Session session);
  
  // GET /analytics/monthly
  Future<MonthlyAnalytics> getMonthlyAnalytics(Session session);
  
  // GET /analytics/patterns
  Future<List<MoodPattern>> getPatterns(Session session);
  
  // GET /analytics/mood-distribution
  Future<MoodDistribution> getMoodDistribution(Session session, String period);
  
  // GET /analytics/time-of-day
  Future<TimeOfDayAnalysis> getTimeOfDayAnalysis(Session session);
}
```

---

# PHASE 4: Flask-Serverpod Integration
**Estimated Time: 1 week**

## Task 4.1: Communication Setup
- [ ] Configure secure HTTP communication between Serverpod and Flask
- [ ] Implement retry logic and circuit breaker pattern
- [ ] Set up request timeout handling
- [ ] Configure API authentication (API keys or JWT)

## Task 4.2: Audio Upload Flow
1. Client uploads audio to Serverpod
2. Serverpod stores audio in cloud storage
3. Serverpod sends audio URL to Flask for analysis
4. Flask returns analysis results
5. Serverpod stores results in database
6. Response returned to client

```dart
// Serverpod: voice_analysis_service.dart
class VoiceAnalysisService {
  final FlaskClient _flaskClient;
  
  Future<AnalysisResult> analyzeVoice(String audioUrl, String language, String privacyLevel) async {
    final response = await _flaskClient.post('/analyze', {
      'audio_url': audioUrl,
      'language': language,
      'privacy_level': privacyLevel,
    });
    return AnalysisResult.fromJson(response.body);
  }
}
```

## Task 4.3: Error Handling
- [ ] Handle Flask service unavailability gracefully
- [ ] Implement fallback to acoustic-only analysis
- [ ] Queue failed analyses for retry
- [ ] Log and monitor failures

---

# PHASE 5: Background Jobs & Scheduling
**Estimated Time: 1 week**

## Task 5.1: Scheduled Jobs Setup
- [ ] Daily insight generation job
  - Run analysis on user's week data
  - Generate personalized insights using LLM
- [ ] Pattern detection job (weekly)
  - Analyze mood trends
  - Detect recurring patterns
  - Create pattern alerts
- [ ] Streak calculation job (daily)
  - Update user streaks at midnight
  - Send streak achievements

## Task 5.2: Push Notifications
- [ ] Integrate Firebase Cloud Messaging (FCM)
- [ ] Set up notification scheduling for reminders
- [ ] Implement notification for insights
- [ ] Handle notification preferences

## Task 5.3: Data Cleanup Jobs
- [ ] Audio file cleanup based on retention settings
- [ ] Old session cleanup
- [ ] Log rotation and cleanup

---

# PHASE 6: LLM Integration for Insights
**Estimated Time: 1 week**

## Task 6.1: LLM Service Setup
- [ ] Choose LLM provider (OpenAI GPT-4 / Claude / Open source)
- [ ] Set up API integration
- [ ] Implement prompt engineering for insight generation
- [ ] Set up caching for common insights

## Task 6.2: Insight Generation System
```python
# insight_generator.py
class InsightGenerator:
    def generate_weekly_summary(self, mood_data: List[MoodEntry]) -> str:
        """Generate personalized weekly summary"""
        prompt = f"""
        Based on the following mood check-in data for the past week:
        {format_mood_data(mood_data)}
        
        Generate a warm, supportive insight that:
        1. Acknowledges the overall trend
        2. Highlights positive patterns
        3. Offers one actionable suggestion
        4. Is under 100 words
        5. Uses a friendly, encouraging tone
        """
        return self.llm.generate(prompt)
    
    def detect_patterns(self, mood_data: List[MoodEntry]) -> List[Pattern]:
        """Detect emotional patterns"""
        # Analyze time-of-day patterns
        # Analyze day-of-week patterns
        # Analyze tag correlations
        pass
    
    def generate_personalized_tip(self, current_mood: float, patterns: List[Pattern]) -> str:
        """Generate contextual tips"""
        pass
```

## Task 6.3: Prompt Templates
- [ ] Weekly summary template
- [ ] Pattern detection template
- [ ] Personalized tip template
- [ ] Achievement celebration template
- [ ] Low mood support template

---

# PHASE 7: Security & Privacy
**Estimated Time: 1 week**

## Task 7.1: Data Encryption
- [ ] Encrypt sensitive data at rest (transcripts, audio)
- [ ] Implement end-to-end encryption for audio
- [ ] Secure database connections (SSL)
- [ ] Implement key rotation

## Task 7.2: API Security
- [ ] Rate limiting per user
- [ ] Request validation and sanitization
- [ ] CORS configuration
- [ ] API versioning strategy
- [ ] DDoS protection

## Task 7.3: Compliance
- [ ] GDPR compliance
  - Data export functionality
  - Right to deletion
  - Consent management
- [ ] Data retention policies
- [ ] Privacy policy implementation
- [ ] Audit logging

## Task 7.4: Security Testing
- [ ] SQL injection prevention
- [ ] XSS prevention
- [ ] Authentication bypass testing
- [ ] Penetration testing

---

# PHASE 8: Testing & Quality Assurance
**Estimated Time: 1 week**

## Task 8.1: Serverpod Testing
- [ ] Unit tests for all endpoints
- [ ] Integration tests for database operations
- [ ] API contract tests
- [ ] Authentication flow tests
- [ ] Load testing

## Task 8.2: Flask Testing
- [ ] Unit tests for audio processing
- [ ] Unit tests for NLP pipeline
- [ ] Integration tests for full analysis pipeline
- [ ] Performance testing (audio processing time)
- [ ] Accuracy testing for mood detection

## Task 8.3: End-to-End Testing
- [ ] Full flow testing (client → serverpod → flask → response)
- [ ] Error scenario testing
- [ ] Edge case testing (long audio, silent audio, noise)

---

# PHASE 9: Deployment & DevOps
**Estimated Time: 1 week**

## Task 9.1: Serverpod Deployment
- [ ] Set up production server (AWS/GCP/Azure)
- [ ] Configure SSL certificates
- [ ] Set up reverse proxy (nginx)
- [ ] Configure production database
- [ ] Set up monitoring (Prometheus/Grafana)
- [ ] Configure log aggregation

## Task 9.2: Flask Deployment
- [ ] Containerize Flask application (Docker)
- [ ] Deploy to container service (ECS/Cloud Run/AKS)
- [ ] Set up auto-scaling for ML workloads
- [ ] Configure GPU instances if needed
- [ ] Set up model versioning

## Task 9.3: CI/CD Pipeline
- [ ] Set up GitHub Actions / GitLab CI
- [ ] Automated testing on PR
- [ ] Staging deployment
- [ ] Production deployment with approval
- [ ] Rollback strategy

## Task 9.4: Infrastructure as Code
- [ ] Terraform/Pulumi for infrastructure
- [ ] Environment parity (dev/staging/prod)
- [ ] Secrets management (AWS Secrets Manager / Vault)

---

# PHASE 10: Flutter Client Integration
**Estimated Time: 1 week**

## Task 10.1: Serverpod Client Setup
- [ ] Generate Serverpod client package
- [ ] Configure client authentication
- [ ] Set up connection management
- [ ] Implement offline support (caching)

## Task 10.2: Audio Recording Integration
- [ ] Integrate audio recording package
- [ ] Implement audio compression before upload
- [ ] Handle upload progress
- [ ] Implement retry on failure

## Task 10.3: Replace Dummy Data
- [ ] Replace DummyData class with API calls
- [ ] Update providers to use Serverpod client
- [ ] Implement loading states
- [ ] Implement error handling
- [ ] Add pull-to-refresh functionality

## Task 10.4: Real-time Features
- [ ] Implement WebSocket for real-time updates
- [ ] Live insight notifications
- [ ] Streak updates

---

# PHASE 11: Performance Optimization
**Estimated Time: 3-5 days**

## Task 11.1: Backend Optimization
- [ ] Database query optimization
- [ ] Connection pooling
- [ ] Caching strategy (Redis)
- [ ] CDN for audio files
- [ ] API response compression

## Task 11.2: ML Pipeline Optimization
- [ ] Model quantization for faster inference
- [ ] Batch processing for non-critical operations
- [ ] Caching transcription results
- [ ] Async processing for long audio

## Task 11.3: Client Optimization
- [ ] Implement pagination
- [ ] Lazy loading for history
- [ ] Image/asset caching
- [ ] Background sync

---

# Appendix A: Tech Stack Summary

| Component | Technology | Purpose |
|-----------|------------|---------|
| Flutter Client | Flutter + Riverpod | Mobile/Desktop app |
| Main Backend | Serverpod (Dart) | API server, Auth, DB |
| AI Service | Flask (Python) | Voice analysis, ML |
| Database | PostgreSQL | Primary data store |
| Cache | Redis | Session, API caching |
| Storage | AWS S3 / GCS | Audio file storage |
| STT | OpenAI Whisper | Speech-to-text |
| Audio Analysis | librosa, praat-parselmouth | Acoustic features |
| NLP | transformers (HuggingFace) | Sentiment, emotion |
| LLM | OpenAI GPT-4 / Claude | Insight generation |
| Push Notifications | Firebase FCM | Mobile notifications |
| Monitoring | Prometheus + Grafana | System monitoring |
| Logging | ELK Stack / CloudWatch | Log management |

---

# Appendix B: Database Schema (ERD)

```
┌─────────────────┐     ┌───────────────────┐     ┌─────────────────┐
│     users       │     │   voice_entries   │     │    insights     │
├─────────────────┤     ├───────────────────┤     ├─────────────────┤
│ id (PK)         │────▶│ id (PK)           │     │ id (PK)         │
│ email           │     │ user_id (FK)      │◀────│ user_id (FK)    │
│ password_hash   │     │ recorded_at       │     │ insight_text    │
│ name            │     │ audio_url         │     │ insight_type    │
│ avatar_url      │     │ duration_seconds  │     │ generated_at    │
│ created_at      │     │ pitch_mean        │     │ is_read         │
│ last_login_at   │     │ energy_mean       │     └─────────────────┘
│ total_checkins  │     │ transcript        │
│ current_streak  │     │ final_mood_score  │     ┌─────────────────┐
│ average_mood    │     │ mood_label        │     │ user_settings   │
│ is_verified     │     │ confidence        │     ├─────────────────┤
└─────────────────┘     │ note              │     │ id (PK)         │
         │              │ privacy_level     │     │ user_id (FK)    │
         │              └───────────────────┘     │ reminder_time   │
         │                                        │ dark_mode       │
         │              ┌───────────────────┐     │ privacy_level   │
         │              │      tags         │     └─────────────────┘
         │              ├───────────────────┤
         └─────────────▶│ id (PK)           │     ┌─────────────────┐
                        │ user_id (FK)      │     │ wellness_goals  │
                        │ name              │     ├─────────────────┤
                        │ color             │     │ id (PK)         │
                        │ usage_count       │     │ user_id (FK)    │
                        └───────────────────┘     │ title           │
                                                  │ is_completed    │
┌─────────────────┐     ┌───────────────────┐     └─────────────────┘
│ journal_entries │     │ gratitude_entries │
├─────────────────┤     ├───────────────────┤     ┌─────────────────┐
│ id (PK)         │     │ id (PK)           │     │favorite_contacts│
│ user_id (FK)    │     │ user_id (FK)      │     ├─────────────────┤
│ content         │     │ items (array)     │     │ id (PK)         │
│ prompt          │     │ created_at        │     │ user_id (FK)    │
│ created_at      │     └───────────────────┘     │ name            │
└─────────────────┘                               │ type            │
                                                  └─────────────────┘
```

---

# Appendix C: API Rate Limits

| Endpoint Category | Rate Limit | Notes |
|-------------------|------------|-------|
| Authentication | 5/min | Login, signup |
| Voice Upload | 10/hour | Audio analysis |
| Read Operations | 100/min | Get entries, insights |
| Write Operations | 30/min | Update, delete |
| Insight Generation | 5/day | LLM-based |

---

# Appendix D: Privacy Levels Explained

| Level | Audio Storage | Transcription | Keywords | Acoustic | Accuracy |
|-------|--------------|---------------|----------|----------|----------|
| `full` | ✅ Encrypted | ✅ Stored | ✅ Stored | ✅ | 95% |
| `context` | ✅ Encrypted | ⚠️ Temporary | ✅ Stored | ✅ | 85% |
| `keywords` | ✅ Encrypted | ❌ | ✅ Extracted | ✅ | 75% |
| `acoustic` | ✅ Encrypted | ❌ | ❌ | ✅ | 65% |

---

# Appendix E: Estimated Timeline Summary

| Phase | Description | Duration |
|-------|-------------|----------|
| 1 | Serverpod Setup & Infrastructure | 1-2 weeks |
| 2 | Flask AI/ML Service | 2-3 weeks |
| 3 | Serverpod API Endpoints | 1-2 weeks |
| 4 | Flask-Serverpod Integration | 1 week |
| 5 | Background Jobs & Scheduling | 1 week |
| 6 | LLM Integration | 1 week |
| 7 | Security & Privacy | 1 week |
| 8 | Testing & QA | 1 week |
| 9 | Deployment & DevOps | 1 week |
| 10 | Flutter Client Integration | 1 week |
| 11 | Performance Optimization | 3-5 days |
| **Total** | | **12-16 weeks** |

---

# Next Steps

1. **Start with Phase 1**: Set up Serverpod project and database
2. **Parallel Development**: Start Flask ML pipeline (Phase 2) while Serverpod is being set up
3. **Integration Sprint**: Combine both services (Phase 4) 
4. **MVP Target**: Phases 1-4 for minimum viable product
5. **Production Sprint**: Phases 5-9 for production readiness
6. **Polish Sprint**: Phases 10-11 for optimization

---

*Document Version: 1.0*
*Last Updated: January 26, 2026*
*Author: Resonate Development Team*
