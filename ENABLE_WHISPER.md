# Enable Real Speech-to-Text with Whisper

Currently, the app is running in **Demo Mode** with mock transcription. To enable real speech-to-text transcription, you need to install OpenAI's Whisper model.

## Prerequisites

- Python 3.8 or higher
- FFmpeg (required by librosa for audio processing)

## Step 1: Install FFmpeg

### Windows:
1. Download FFmpeg from: https://www.gyan.dev/ffmpeg/builds/
2. Extract to `C:\ffmpeg`
3. Add `C:\ffmpeg\bin` to your system PATH
4. Restart your terminal

### Verify Installation:
```bash
ffmpeg -version
```

## Step 2: Install Whisper

```bash
cd resonate_python
pip install openai-whisper
```

## Step 3: Update semantic_analyzer.py

Replace the `_mock_transcription` method with real Whisper transcription:

```python
import whisper

class SemanticAnalyzer:
    def __init__(self):
        """Initialize semantic analysis models"""
        self.vader = SentimentIntensityAnalyzer()
        # Load Whisper model (base is good balance of speed/accuracy)
        self.whisper_model = whisper.load_model("base")
        logger.info("Semantic analyzer initialized with Whisper STT")
    
    def _transcribe_audio(self, audio_path, language='en'):
        """Transcribe audio using Whisper"""
        try:
            result = self.whisper_model.transcribe(
                audio_path,
                language=language if language != 'bn' else 'bn',
                fp16=False  # Use fp32 for CPU
            )
            return result['text']
        except Exception as e:
            logger.error(f"Whisper transcription error: {e}")
            return ""
```

Then update the `analyze` method to use `_transcribe_audio` instead of `_mock_transcription`.

## Step 4: Restart Python Service

```bash
cd resonate_python
python app.py
```

## Whisper Model Sizes

- **tiny**: Fastest, least accurate (~1GB RAM)
- **base**: Good balance (~1GB RAM) - **Recommended**
- **small**: Better accuracy (~2GB RAM)
- **medium**: High accuracy (~5GB RAM)
- **large**: Best accuracy (~10GB RAM)

## Notes

- First run will download the model (~140MB for base)
- Transcription adds 2-5 seconds to analysis time
- Bengali (bn) language is supported
- The app will continue to work with mock transcription if Whisper is not installed

## Current Status

✅ Acoustic analysis (voice tone, pitch, energy) - **Working**
✅ Emotion detection from keywords - **Working**
✅ Mood scoring and fusion - **Working**
⚠️ Speech-to-text transcription - **Demo Mode (requires Whisper)**

The emotional analysis still works accurately based on your voice characteristics, even without transcription!
