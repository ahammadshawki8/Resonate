# Resonate Python AI Service

Flask-based AI service for voice emotion analysis using multi-modal approach (acoustic + semantic).

## Features

- **Acoustic Analysis**: Extracts pitch, energy, tempo, and spectral features using librosa
- **Speech-to-Text**: Transcribes audio using OpenAI Whisper (English + Bengali)
- **Sentiment Analysis**: Analyzes emotional content using NLP
- **Multi-Modal Fusion**: Combines acoustic and semantic signals for accurate mood detection
- **AI Insights**: Generates personalized insights using Groq LLM
- **Privacy Levels**: Supports 4 privacy modes (full, context, keywords, acoustic)

## Installation

### 1. Install Python Dependencies

```bash
cd resonate_python
pip install -r requirements.txt
```

### 2. Download NLTK Data (for sentiment analysis)

```python
python -c "import nltk; nltk.download('punkt'); nltk.download('vader_lexicon')"
```

### 3. Configure Environment

Copy `.env.example` to `.env` and add your Groq API key:

```bash
cp .env.example .env
```

Edit `.env`:
```
GROQ_API_KEY=your_groq_api_key_here
```

Get a free Groq API key at: https://console.groq.com/keys
- Free tier: 14,400 requests/day
- No credit card required

## Usage

### Start the Service

```bash
python app.py
```

The service will start on `http://localhost:8001`

### API Endpoints

#### 1. Health Check
```bash
GET /health
```

#### 2. Get Supported Languages
```bash
GET /languages
```

#### 3. Analyze Audio (Full Analysis)
```bash
POST /analyze
Content-Type: multipart/form-data

Parameters:
- audio: Audio file (wav, mp3, m4a, aac, flac)
- language: 'en' or 'bn' (default: 'en')
- privacy_level: 'full', 'context', 'keywords', or 'acoustic' (default: 'full')
```

Example with curl:
```bash
curl -X POST http://localhost:8001/analyze \
  -F "audio=@recording.m4a" \
  -F "language=en" \
  -F "privacy_level=full"
```

#### 4. Acoustic Analysis Only
```bash
POST /analyze/acoustic
Content-Type: multipart/form-data

Parameters:
- audio: Audio file
```

#### 5. Transcription Only
```bash
POST /transcribe
Content-Type: multipart/form-data

Parameters:
- audio: Audio file
- language: 'en' or 'bn'
```

#### 6. Generate AI Insight
```bash
POST /insights/generate
Content-Type: application/json

Body:
{
  "mood_history": [
    {
      "date": "2026-01-20",
      "mood_score": 0.72,
      "mood_label": "positive",
      "emotions": ["happy", "hopeful"]
    }
  ],
  "type": "weekly_summary"
}
```

## Response Format

### Full Analysis Response

```json
{
  "acoustic": {
    "duration_seconds": 15.3,
    "pitch_mean": 145.2,
    "pitch_std": 23.5,
    "energy_mean": 0.072,
    "tempo": 118.5,
    "silence_ratio": 0.15,
    "acoustic_mood_score": 0.72,
    "mood_label": "positive"
  },
  "semantic": {
    "transcript": "I had a really good day today...",
    "language": "en",
    "sentiment_score": 0.68,
    "detected_emotions": ["happy", "hopeful"],
    "emotion_keywords": ["good", "excited"],
    "topic_context": "work",
    "semantic_mood_score": 0.68
  },
  "fusion": {
    "final_mood_score": 0.70,
    "mood_label": "positive",
    "confidence": 0.87,
    "signal_alignment": 0.92,
    "acoustic_contribution": 0.4,
    "semantic_contribution": 0.6
  }
}
```

## Privacy Levels

| Level | Audio Storage | Transcription | Keywords | Acoustic | Accuracy |
|-------|--------------|---------------|----------|----------|----------|
| `full` | ✅ | ✅ Stored | ✅ | ✅ | 95% |
| `context` | ✅ | ⚠️ Temporary | ✅ | ✅ | 85% |
| `keywords` | ✅ | ❌ | ✅ Extracted | ✅ | 75% |
| `acoustic` | ✅ | ❌ | ❌ | ✅ | 65% |

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Flask App (app.py)                    │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  ┌──────────────────┐      ┌──────────────────┐        │
│  │ AcousticAnalyzer │      │ SemanticAnalyzer │        │
│  │   (librosa)      │      │   (Whisper+NLP)  │        │
│  └────────┬─────────┘      └────────┬─────────┘        │
│           │                         │                   │
│           └────────┬────────────────┘                   │
│                    ▼                                     │
│           ┌─────────────────┐                           │
│           │  FusionModel    │                           │
│           │  (Multi-modal)  │                           │
│           └────────┬────────┘                           │
│                    │                                     │
│                    ▼                                     │
│           ┌─────────────────┐                           │
│           │InsightGenerator │                           │
│           │   (Groq LLM)    │                           │
│           └─────────────────┘                           │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

## Performance

- **Acoustic Analysis**: ~1-2 seconds
- **Transcription (Whisper base)**: ~3-5 seconds for 15s audio
- **Sentiment Analysis**: <1 second
- **Total Analysis Time**: ~5-8 seconds for 15s audio

## Troubleshooting

### Whisper Installation Issues

If you encounter issues with Whisper, try:
```bash
pip install --upgrade openai-whisper
```

For CPU-only systems:
```bash
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
```

### NLTK Data Missing

```python
import nltk
nltk.download('punkt')
nltk.download('vader_lexicon')
```

### Groq API Errors

- Check your API key is correct in `.env`
- Verify you haven't exceeded rate limits (14,400/day)
- Service will fall back to template insights if Groq is unavailable

## Development

### Run in Debug Mode

```bash
DEBUG=True python app.py
```

### Test Endpoints

```bash
# Health check
curl http://localhost:8001/health

# Test with sample audio
curl -X POST http://localhost:8001/analyze \
  -F "audio=@test_audio.m4a" \
  -F "language=en"
```

## Integration with Serverpod

The Serverpod backend calls this service via HTTP:

```dart
// In Serverpod: voice_entry_endpoint.dart
final response = await http.post(
  Uri.parse('http://localhost:8001/analyze'),
  body: {
    'audio': audioFile,
    'language': language,
    'privacy_level': privacyLevel,
  },
);
```

## License

Part of the Resonate emotional wellness application.
