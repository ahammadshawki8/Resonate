"""
Configuration management for Resonate Python AI Service
"""

import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()


class Config:
    """Application configuration"""
    
    # Flask
    PORT = int(os.getenv('PORT', 8001))
    DEBUG = os.getenv('DEBUG', 'False').lower() == 'true'
    
    # API Keys
    GROQ_API_KEY = os.getenv('GROQ_API_KEY')
    
    # Audio Processing
    MAX_AUDIO_DURATION = int(os.getenv('MAX_AUDIO_DURATION', 60))
    UPLOAD_FOLDER = os.getenv('UPLOAD_FOLDER', 'temp_audio')
    ALLOWED_EXTENSIONS = {'wav', 'mp3', 'm4a', 'aac', 'flac'}
    
    # Logging
    LOG_LEVEL = os.getenv('LOG_LEVEL', 'INFO')
    
    # Whisper Model
    WHISPER_MODEL = 'tiny'  # Options: tiny, base, small, medium, large
    
    # Groq Model
    GROQ_MODEL = 'llama-3.3-70b-versatile'
    
    @classmethod
    def validate(cls):
        """Validate configuration"""
        if not cls.GROQ_API_KEY:
            print("WARNING: GROQ_API_KEY not set. Insight generation will use fallback mode.")
        
        # Create upload folder if it doesn't exist
        os.makedirs(cls.UPLOAD_FOLDER, exist_ok=True)
