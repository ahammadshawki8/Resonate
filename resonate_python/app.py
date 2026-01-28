"""
Resonate Audio Analysis Service
Flask backend for voice emotion analysis using multi-modal approach
"""

from flask import Flask, request, jsonify
from flask_cors import CORS
import os
import logging
from dotenv import load_dotenv

# Import analysis modules
from acoustic_analyzer import AcousticAnalyzer
from semantic_analyzer import SemanticAnalyzer
from fusion_model import FusionModel
from insight_generator import InsightGenerator
from config import Config

# Load environment variables
load_dotenv()

# Validate configuration
Config.validate()

# Initialize Flask app
app = Flask(__name__)
CORS(app)  # Enable CORS for Flutter app

# Configure logging
logging.basicConfig(
    level=getattr(logging, Config.LOG_LEVEL),
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

# Initialize analyzers
logger.info("Initializing analyzers...")
acoustic_analyzer = AcousticAnalyzer()
semantic_analyzer = SemanticAnalyzer()
fusion_model = FusionModel()
insight_generator = InsightGenerator()
logger.info("All analyzers initialized successfully")

# Configuration
UPLOAD_FOLDER = Config.UPLOAD_FOLDER
ALLOWED_EXTENSIONS = Config.ALLOWED_EXTENSIONS
MAX_AUDIO_DURATION = Config.MAX_AUDIO_DURATION


def allowed_file(filename):
    """Check if file extension is allowed"""
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


@app.route('/health', methods=['GET'])
def health_check():
    """Health check endpoint"""
    return jsonify({
        'status': 'ok',
        'service': 'Resonate Audio Analysis',
        'version': '1.0.0'
    }), 200


@app.route('/languages', methods=['GET'])
def get_languages():
    """Get supported languages"""
    return jsonify({
        'languages': ['en', 'bn'],
        'descriptions': {
            'en': 'English',
            'bn': 'Bengali (বাংলা)'
        }
    }), 200


@app.route('/analyze', methods=['POST'])
def analyze_audio():
    """
    Main endpoint for audio analysis
    Performs acoustic + semantic analysis and returns fused results
    """
    try:
        # Check if audio file is present
        if 'audio' not in request.files:
            return jsonify({'error': 'No audio file provided'}), 400
        
        audio_file = request.files['audio']
        
        if audio_file.filename == '':
            return jsonify({'error': 'No file selected'}), 400
        
        if not allowed_file(audio_file.filename):
            return jsonify({'error': 'Invalid file format'}), 400
        
        # Get parameters
        language = request.form.get('language', 'en')
        privacy_level = request.form.get('privacy_level', 'full')
        
        logger.info(f"Analyzing audio: {audio_file.filename}, language: {language}")
        
        # Save audio file temporarily
        filename = f"temp_{os.urandom(8).hex()}.{audio_file.filename.rsplit('.', 1)[1]}"
        filepath = os.path.join(UPLOAD_FOLDER, filename)
        audio_file.save(filepath)
        
        try:
            # Step 1: Acoustic Analysis
            logger.info("Performing acoustic analysis...")
            acoustic_result = acoustic_analyzer.analyze(filepath)
            
            # Step 2: Semantic Analysis (if privacy allows)
            semantic_result = None
            if privacy_level in ['full', 'context', 'keywords']:
                logger.info("Performing semantic analysis...")
                semantic_result = semantic_analyzer.analyze(filepath, language)
            
            # Step 3: Fusion
            logger.info("Fusing results...")
            fusion_result = fusion_model.fuse(
                acoustic_result,
                semantic_result,
                privacy_level
            )
            
            # Build response based on privacy level
            response = {
                'acoustic': acoustic_result,
                'fusion': fusion_result,
                'analysis_duration_ms': acoustic_result.get('duration_ms', 0)
            }
            
            # Add semantic data based on privacy level
            if privacy_level == 'full' and semantic_result:
                response['semantic'] = semantic_result
            elif privacy_level == 'context' and semantic_result:
                response['semantic'] = {
                    'sentiment_score': semantic_result.get('sentiment_score'),
                    'detected_emotions': semantic_result.get('detected_emotions'),
                    'topic_context': semantic_result.get('topic_context')
                }
            elif privacy_level == 'keywords' and semantic_result:
                response['semantic'] = {
                    'emotion_keywords': semantic_result.get('emotion_keywords'),
                    'detected_emotions': semantic_result.get('detected_emotions')
                }
            
            logger.info(f"Analysis complete. Mood: {fusion_result.get('mood_label')}")
            
            return jsonify(response), 200
            
        finally:
            # Clean up temporary file
            if os.path.exists(filepath):
                os.remove(filepath)
                logger.info(f"Cleaned up temporary file: {filename}")
    
    except Exception as e:
        logger.error(f"Error during analysis: {str(e)}", exc_info=True)
        return jsonify({'error': str(e)}), 500


@app.route('/analyze/acoustic', methods=['POST'])
def analyze_acoustic_only():
    """Acoustic analysis only (no transcription)"""
    try:
        if 'audio' not in request.files:
            return jsonify({'error': 'No audio file provided'}), 400
        
        audio_file = request.files['audio']
        
        if not allowed_file(audio_file.filename):
            return jsonify({'error': 'Invalid file format'}), 400
        
        # Save temporarily
        filename = f"temp_{os.urandom(8).hex()}.{audio_file.filename.rsplit('.', 1)[1]}"
        filepath = os.path.join(UPLOAD_FOLDER, filename)
        audio_file.save(filepath)
        
        try:
            result = acoustic_analyzer.analyze(filepath)
            return jsonify(result), 200
        finally:
            if os.path.exists(filepath):
                os.remove(filepath)
    
    except Exception as e:
        logger.error(f"Error in acoustic analysis: {str(e)}")
        return jsonify({'error': str(e)}), 500


@app.route('/transcribe', methods=['POST'])
def transcribe_audio():
    """Transcription only endpoint"""
    try:
        if 'audio' not in request.files:
            return jsonify({'error': 'No audio file provided'}), 400
        
        audio_file = request.files['audio']
        language = request.form.get('language', 'en')
        
        if not allowed_file(audio_file.filename):
            return jsonify({'error': 'Invalid file format'}), 400
        
        # Save temporarily
        filename = f"temp_{os.urandom(8).hex()}.{audio_file.filename.rsplit('.', 1)[1]}"
        filepath = os.path.join(UPLOAD_FOLDER, filename)
        audio_file.save(filepath)
        
        try:
            result = semantic_analyzer.transcribe_only(filepath, language)
            return jsonify(result), 200
        finally:
            if os.path.exists(filepath):
                os.remove(filepath)
    
    except Exception as e:
        logger.error(f"Error in transcription: {str(e)}")
        return jsonify({'error': str(e)}), 500


@app.route('/insights/generate', methods=['POST'])
def generate_insight():
    """Generate AI insight from mood history"""
    try:
        data = request.get_json()
        
        if not data or 'entries' not in data:
            return jsonify({'error': 'No entries provided'}), 400
        
        entries = data['entries']
        
        logger.info(f"Generating insight for {len(entries)} entries")
        
        insight = insight_generator.generate_insight(entries)
        
        return jsonify(insight), 200
    
    except Exception as e:
        logger.error(f"Error generating insight: {str(e)}")
        return jsonify({'error': str(e)}), 500


@app.errorhandler(404)
def not_found(error):
    return jsonify({'error': 'Endpoint not found'}), 404


@app.errorhandler(500)
def internal_error(error):
    return jsonify({'error': 'Internal server error'}), 500


if __name__ == '__main__':
    logger.info("=" * 60)
    logger.info("Resonate Audio Analysis Service")
    logger.info("=" * 60)
    logger.info(f"Port: {Config.PORT}")
    logger.info(f"Debug: {Config.DEBUG}")
    logger.info(f"Whisper Model: {Config.WHISPER_MODEL}")
    logger.info(f"Groq API: {'Configured' if Config.GROQ_API_KEY else 'Not configured (using fallback)'}")
    logger.info("=" * 60)
    
    app.run(host='0.0.0.0', port=Config.PORT, debug=Config.DEBUG)
