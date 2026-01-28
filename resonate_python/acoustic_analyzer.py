"""
Acoustic Feature Extraction using librosa
Analyzes HOW the user speaks (pitch, energy, tempo, etc.)
"""

import librosa
import numpy as np
import logging
from typing import Dict, Any

logger = logging.getLogger(__name__)


class AcousticAnalyzer:
    """Extracts acoustic features from audio to determine emotional state"""
    
    def __init__(self):
        self.sample_rate = 22050  # Standard sample rate for librosa
        
    def analyze(self, audio_path: str) -> Dict[str, Any]:
        """
        Perform complete acoustic analysis on audio file
        
        Args:
            audio_path: Path to audio file
            
        Returns:
            Dictionary with acoustic features and mood score
        """
        try:
            logger.info(f"Loading audio file: {audio_path}")
            
            # Load audio file
            y, sr = librosa.load(audio_path, sr=self.sample_rate)
            duration = librosa.get_duration(y=y, sr=sr)
            
            logger.info(f"Audio loaded: {duration:.2f}s, sr={sr}")
            
            # Extract features
            features = {
                'duration_seconds': float(duration),
                'sample_rate': sr
            }
            
            # Pitch features
            pitch_features = self._extract_pitch_features(y, sr)
            features.update(pitch_features)
            
            # Energy features
            energy_features = self._extract_energy_features(y)
            features.update(energy_features)
            
            # Temporal features
            temporal_features = self._extract_temporal_features(y, sr)
            features.update(temporal_features)
            
            # Spectral features
            spectral_features = self._extract_spectral_features(y, sr)
            features.update(spectral_features)
            
            # Calculate acoustic mood score
            mood_score = self._calculate_acoustic_mood(features)
            features['acoustic_mood_score'] = mood_score
            features['mood_label'] = self._score_to_label(mood_score)
            
            logger.info(f"Acoustic analysis complete. Mood: {features['mood_label']} ({mood_score:.2f})")
            
            return features
            
        except Exception as e:
            logger.error(f"Error in acoustic analysis: {str(e)}", exc_info=True)
            raise
    
    def _extract_pitch_features(self, y: np.ndarray, sr: int) -> Dict[str, float]:
        """Extract pitch (F0) features"""
        try:
            # Use pyin algorithm for pitch tracking
            f0, voiced_flag, voiced_probs = librosa.pyin(
                y,
                fmin=librosa.note_to_hz('C2'),  # ~65 Hz
                fmax=librosa.note_to_hz('C7')   # ~2093 Hz
            )
            
            # Remove NaN values (unvoiced segments)
            f0_clean = f0[~np.isnan(f0)]
            
            if len(f0_clean) > 0:
                pitch_mean = float(np.mean(f0_clean))
                pitch_std = float(np.std(f0_clean))
                pitch_range = float(np.max(f0_clean) - np.min(f0_clean))
            else:
                pitch_mean = 0.0
                pitch_std = 0.0
                pitch_range = 0.0
            
            return {
                'pitch_mean': pitch_mean,
                'pitch_std': pitch_std,
                'pitch_range': pitch_range,
                'voiced_ratio': float(np.sum(voiced_flag) / len(voiced_flag))
            }
            
        except Exception as e:
            logger.warning(f"Pitch extraction failed: {str(e)}")
            return {
                'pitch_mean': 0.0,
                'pitch_std': 0.0,
                'pitch_range': 0.0,
                'voiced_ratio': 0.0
            }
    
    def _extract_energy_features(self, y: np.ndarray) -> Dict[str, float]:
        """Extract energy/intensity features"""
        # RMS energy
        rms = librosa.feature.rms(y=y)[0]
        
        return {
            'energy_mean': float(np.mean(rms)),
            'energy_std': float(np.std(rms)),
            'energy_max': float(np.max(rms))
        }
    
    def _extract_temporal_features(self, y: np.ndarray, sr: int) -> Dict[str, float]:
        """Extract temporal features (tempo, pauses, etc.)"""
        # Tempo estimation
        tempo, _ = librosa.beat.beat_track(y=y, sr=sr)
        
        # Voice activity detection (simple energy-based)
        rms = librosa.feature.rms(y=y)[0]
        threshold = np.mean(rms) * 0.3
        silence_frames = np.sum(rms < threshold)
        silence_ratio = silence_frames / len(rms)
        
        return {
            'tempo': float(tempo),
            'silence_ratio': float(silence_ratio)
        }
    
    def _extract_spectral_features(self, y: np.ndarray, sr: int) -> Dict[str, Any]:
        """Extract spectral features (MFCCs, etc.)"""
        # MFCCs (Mel-frequency cepstral coefficients)
        mfccs = librosa.feature.mfcc(y=y, sr=sr, n_mfcc=13)
        
        # Spectral centroid (brightness)
        spectral_centroid = librosa.feature.spectral_centroid(y=y, sr=sr)[0]
        
        # Spectral rolloff
        spectral_rolloff = librosa.feature.spectral_rolloff(y=y, sr=sr)[0]
        
        return {
            'mfcc_mean': [float(x) for x in np.mean(mfccs, axis=1)],
            'spectral_centroid_mean': float(np.mean(spectral_centroid)),
            'spectral_rolloff_mean': float(np.mean(spectral_rolloff))
        }
    
    def _calculate_acoustic_mood(self, features: Dict[str, Any]) -> float:
        """
        Calculate mood score from acoustic features
        
        Based on research correlations:
        - Higher pitch variability → more emotional expressiveness
        - Higher energy → more positive/energetic
        - Faster tempo with energy → excitement/happiness
        - Slower tempo with lower energy → sadness/tiredness
        - Long pauses → hesitation, anxiety, or sadness
        
        Returns:
            Mood score between 0.0 (very negative) and 1.0 (very positive)
        """
        score = 0.5  # Neutral baseline
        
        # Pitch analysis (±0.15)
        pitch_std = features.get('pitch_std', 0)
        if pitch_std > 30:  # High variability → expressive
            score += 0.10
        elif pitch_std > 20:
            score += 0.05
        elif pitch_std < 10:  # Low variability → monotone/sad
            score -= 0.10
        
        # Energy analysis (±0.20)
        energy_mean = features.get('energy_mean', 0)
        if energy_mean > 0.08:  # High energy → positive
            score += 0.15
        elif energy_mean > 0.05:
            score += 0.08
        elif energy_mean < 0.03:  # Low energy → tired/sad
            score -= 0.15
        
        # Tempo analysis (±0.15)
        tempo = features.get('tempo', 100)
        if tempo > 130:  # Fast speech → excited/anxious
            if energy_mean > 0.06:  # High energy → excited
                score += 0.12
            else:  # Low energy → anxious
                score -= 0.05
        elif tempo < 90:  # Slow speech → sad/tired
            score -= 0.12
        
        # Silence ratio (±0.10)
        silence_ratio = features.get('silence_ratio', 0.2)
        if silence_ratio > 0.4:  # Many pauses → hesitation/sadness
            score -= 0.10
        elif silence_ratio < 0.15:  # Few pauses → confident/excited
            score += 0.08
        
        # Voiced ratio (±0.05)
        voiced_ratio = features.get('voiced_ratio', 0.7)
        if voiced_ratio < 0.5:  # Lots of unvoiced → whisper/sad
            score -= 0.05
        
        # Clamp to [0, 1]
        return max(0.0, min(1.0, score))
    
    def _score_to_label(self, score: float) -> str:
        """Convert numeric score to mood label"""
        if score >= 0.7:
            return 'very_positive'
        elif score >= 0.55:
            return 'positive'
        elif score >= 0.45:
            return 'neutral'
        elif score >= 0.3:
            return 'negative'
        else:
            return 'very_negative'
