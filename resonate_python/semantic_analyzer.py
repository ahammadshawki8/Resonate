"""
Semantic Analyzer - Speech-to-Text and NLP Analysis
Extracts meaning from what the user says
"""

import logging
import requests
from textblob import TextBlob
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
from emotion_keywords import EMOTION_KEYWORDS

logger = logging.getLogger(__name__)


class SemanticAnalyzer:
    """Analyzes semantic content of speech"""
    
    def __init__(self):
        """Initialize semantic analysis models"""
        self.vader = SentimentIntensityAnalyzer()
        from config import Config
        self.openai_api_key = getattr(Config, 'OPENAI_API_KEY', None) or os.getenv('OPENAI_API_KEY')
        if not self.openai_api_key:
            logger.warning("OPENAI_API_KEY not set. Whisper API transcription will fail.")
    
    def analyze(self, audio_path, language='en'):
        """
        Perform semantic analysis on audio
        
        Args:
            audio_path: Path to audio file
            language: Language code ('en' or 'bn')
            
        Returns:
            dict: Semantic analysis results
        """
        try:
            # Real transcription using Whisper
            transcript = self._transcribe_audio(audio_path, language)
            
            if not transcript or transcript.strip() == "":
                logger.warning("Empty transcript, using fallback")
                return self._fallback_analysis(language)
            
            # Sentiment analysis
            sentiment_score = self._analyze_sentiment(transcript)
            
            # Emotion keyword extraction
            emotion_keywords = self._extract_emotion_keywords(transcript, language)
            detected_emotions = self._detect_emotions(transcript, language)
            
            # Topic context
            topic_context = self._extract_topic(transcript)
            
            # Semantic mood score (0-1)
            semantic_mood_score = self._calculate_semantic_mood(sentiment_score, detected_emotions)
            
            return {
                'transcript': transcript,
                'sentiment_score': sentiment_score,
                'emotion_keywords': emotion_keywords,
                'detected_emotions': detected_emotions,
                'topic_context': topic_context,
                'semantic_mood_score': semantic_mood_score,
                'language': language
            }
            
        except Exception as e:
            logger.error(f"Semantic analysis error: {str(e)}", exc_info=True)
            return self._fallback_analysis(language)
    
    def transcribe_only(self, audio_path, language='en'):
        """Transcribe audio without full analysis"""
        try:
            transcript = self._transcribe_audio(audio_path, language)
            return {'transcript': transcript, 'language': language}
        except Exception as e:
            logger.error(f"Transcription error: {str(e)}")
            return {'transcript': '', 'language': language, 'error': str(e)}
    
    def _transcribe_audio(self, audio_path, language='en'):
        """Transcribe audio using OpenAI Whisper API"""
        try:
            logger.info(f"Transcribing audio with OpenAI Whisper API (language: {language})...")
            if not self.openai_api_key:
                logger.error("OPENAI_API_KEY not set. Cannot transcribe.")
                return ""
            with open(audio_path, 'rb') as audio_file:
                files = {'file': audio_file}
                data = {
                    'model': 'whisper-1',
                    'language': language
                }
                headers = {
                    'Authorization': f'Bearer {self.openai_api_key}'
                }
                response = requests.post(
                    'https://api.openai.com/v1/audio/transcriptions',
                    files=files,
                    data=data,
                    headers=headers
                )
                response.raise_for_status()
                transcript = response.json().get('text', '').strip()
                logger.info(f"Transcription complete: {len(transcript)} characters")
                return transcript
        except Exception as e:
            logger.error(f"OpenAI Whisper API transcription error: {str(e)}")
            return ""
    
    def _analyze_sentiment(self, text):
        """Analyze sentiment using VADER"""
        try:
            scores = self.vader.polarity_scores(text)
            return scores['compound']
        except Exception as e:
            logger.error(f"Sentiment analysis error: {str(e)}")
            return 0.0
    
    def _extract_emotion_keywords(self, text, language):
        """Extract emotion keywords from text"""
        try:
            text_lower = text.lower()
            keywords = []
            
            if language in EMOTION_KEYWORDS:
                for emotion, words in EMOTION_KEYWORDS[language].items():
                    for word in words:
                        if word in text_lower:
                            keywords.append(word)
                            break
            
            return keywords[:5]  # Return top 5
        except Exception as e:
            logger.error(f"Keyword extraction error: {str(e)}")
            return []
    
    def _detect_emotions(self, text, language):
        """Detect emotions from text"""
        try:
            text_lower = text.lower()
            emotions = []
            
            if language in EMOTION_KEYWORDS:
                for emotion, words in EMOTION_KEYWORDS[language].items():
                    if any(word in text_lower for word in words):
                        emotions.append(emotion)
            
            return emotions if emotions else ['neutral']
        except Exception as e:
            logger.error(f"Emotion detection error: {str(e)}")
            return ['neutral']
    
    def _extract_topic(self, text):
        """Extract general topic/context"""
        try:
            blob = TextBlob(text)
            noun_phrases = list(blob.noun_phrases)
            if noun_phrases:
                return ', '.join(noun_phrases[:3])
            return 'general'
        except Exception as e:
            logger.error(f"Topic extraction error: {str(e)}")
            return 'general'
    
    def _calculate_semantic_mood(self, sentiment_score, emotions):
        """Calculate mood score from semantic features"""
        # Base score from sentiment (-1 to 1) -> (0 to 1)
        mood_score = (sentiment_score + 1) / 2
        
        # Adjust based on detected emotions
        positive_emotions = ['happy', 'hopeful', 'content', 'excited', 'grateful']
        negative_emotions = ['sad', 'anxious', 'stressed', 'angry', 'frustrated']
        
        positive_count = sum(1 for e in emotions if e in positive_emotions)
        negative_count = sum(1 for e in emotions if e in negative_emotions)
        
        # Adjust mood score
        if positive_count > negative_count:
            mood_score = min(1.0, mood_score + 0.1)
        elif negative_count > positive_count:
            mood_score = max(0.0, mood_score - 0.1)
        
        return mood_score
    
    def _fallback_analysis(self, language):
        """Fallback analysis when main analysis fails"""
        return {
            'transcript': self._mock_transcription(language),
            'sentiment_score': 0.0,
            'emotion_keywords': [],
            'detected_emotions': ['neutral'],
            'topic_context': 'general',
            'semantic_mood_score': 0.5,
            'language': language
        }
