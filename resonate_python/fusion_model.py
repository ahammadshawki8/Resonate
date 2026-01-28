"""
Multi-Modal Fusion Model
Combines acoustic and semantic analysis for final mood score
"""

import logging
from typing import Dict, Any, Optional

logger = logging.getLogger(__name__)


class FusionModel:
    """Fuses acoustic and semantic signals for final mood assessment"""
    
    def fuse(
        self,
        acoustic_result: Dict[str, Any],
        semantic_result: Optional[Dict[str, Any]],
        privacy_level: str
    ) -> Dict[str, Any]:
        """
        Fuse acoustic and semantic analysis results
        
        Args:
            acoustic_result: Results from acoustic analysis
            semantic_result: Results from semantic analysis (None if privacy_level='acoustic')
            privacy_level: Privacy level ('full', 'context', 'keywords', 'acoustic')
            
        Returns:
            Fused analysis with final mood score
        """
        try:
            acoustic_score = acoustic_result.get('acoustic_mood_score', 0.5)
            
            # Acoustic-only mode
            if privacy_level == 'acoustic' or semantic_result is None:
                return self._acoustic_only_fusion(acoustic_result)
            
            semantic_score = semantic_result.get('semantic_mood_score', 0.5)
            
            # Calculate signal alignment
            alignment = self._calculate_alignment(acoustic_score, semantic_score)
            
            # Weighted fusion based on privacy level and alignment
            final_score = self._weighted_fusion(
                acoustic_score,
                semantic_score,
                privacy_level,
                alignment
            )
            
            # Determine confidence
            confidence = self._calculate_confidence(
                acoustic_result,
                semantic_result,
                alignment
            )
            
            # Generate mood label
            mood_label = self._score_to_label(final_score)
            
            result = {
                'final_mood_score': final_score,
                'mood_label': mood_label,
                'confidence': confidence,
                'signal_alignment': alignment,
                'acoustic_contribution': self._get_acoustic_weight(privacy_level, alignment),
                'semantic_contribution': self._get_semantic_weight(privacy_level, alignment)
            }
            
            logger.info(
                f"Fusion complete: {mood_label} ({final_score:.2f}), "
                f"confidence: {confidence:.2f}, alignment: {alignment:.2f}"
            )
            
            return result
            
        except Exception as e:
            logger.error(f"Error in fusion: {str(e)}", exc_info=True)
            # Fallback to acoustic only
            return self._acoustic_only_fusion(acoustic_result)
    
    def _acoustic_only_fusion(self, acoustic_result: Dict[str, Any]) -> Dict[str, Any]:
        """Fallback for acoustic-only analysis"""
        acoustic_score = acoustic_result.get('acoustic_mood_score', 0.5)
        
        return {
            'final_mood_score': acoustic_score,
            'mood_label': self._score_to_label(acoustic_score),
            'confidence': 0.65,  # Lower confidence without semantic data
            'signal_alignment': None,
            'acoustic_contribution': 1.0,
            'semantic_contribution': 0.0
        }
    
    def _calculate_alignment(self, acoustic_score: float, semantic_score: float) -> float:
        """
        Calculate how well acoustic and semantic signals align
        
        High alignment = both signals agree (e.g., happy words + happy tone)
        Low alignment = signals disagree (e.g., sad words + happy tone)
        
        Returns:
            Alignment score between 0.0 (complete disagreement) and 1.0 (perfect agreement)
        """
        # Calculate absolute difference
        diff = abs(acoustic_score - semantic_score)
        
        # Convert to alignment score (inverse of difference)
        # diff=0 → alignment=1.0, diff=1 → alignment=0.0
        alignment = 1.0 - diff
        
        return float(alignment)
    
    def _weighted_fusion(
        self,
        acoustic_score: float,
        semantic_score: float,
        privacy_level: str,
        alignment: float
    ) -> float:
        """
        Calculate weighted average of acoustic and semantic scores
        
        Weights depend on:
        1. Privacy level (more privacy → more acoustic weight)
        2. Signal alignment (high alignment → trust both equally)
        """
        acoustic_weight = self._get_acoustic_weight(privacy_level, alignment)
        semantic_weight = self._get_semantic_weight(privacy_level, alignment)
        
        # Weighted average
        final_score = (
            acoustic_weight * acoustic_score +
            semantic_weight * semantic_score
        )
        
        return float(final_score)
    
    def _get_acoustic_weight(self, privacy_level: str, alignment: float) -> float:
        """Get weight for acoustic signal"""
        # Base weights by privacy level
        base_weights = {
            'acoustic': 1.0,
            'keywords': 0.7,
            'context': 0.5,
            'full': 0.4
        }
        
        base = base_weights.get(privacy_level, 0.5)
        
        # Adjust based on alignment
        # Low alignment → trust acoustic more (it's harder to fake)
        if alignment < 0.7:
            base += 0.1
        
        return min(1.0, base)
    
    def _get_semantic_weight(self, privacy_level: str, alignment: float) -> float:
        """Get weight for semantic signal"""
        acoustic_weight = self._get_acoustic_weight(privacy_level, alignment)
        return 1.0 - acoustic_weight
    
    def _calculate_confidence(
        self,
        acoustic_result: Dict[str, Any],
        semantic_result: Dict[str, Any],
        alignment: float
    ) -> float:
        """
        Calculate confidence in the final mood assessment
        
        Higher confidence when:
        - Both signals are strong
        - Signals are aligned
        - Audio quality is good
        """
        confidence = 0.5  # Base confidence
        
        # Alignment boost (±0.25)
        if alignment > 0.8:
            confidence += 0.25
        elif alignment > 0.6:
            confidence += 0.15
        elif alignment < 0.4:
            confidence -= 0.15
        
        # Audio quality indicators (±0.15)
        duration = acoustic_result.get('duration_seconds', 0)
        if duration > 10:  # Longer audio → more confident
            confidence += 0.10
        elif duration < 3:  # Very short → less confident
            confidence -= 0.10
        
        voiced_ratio = acoustic_result.get('voiced_ratio', 0.7)
        if voiced_ratio > 0.7:  # Good voice activity
            confidence += 0.05
        elif voiced_ratio < 0.4:  # Poor voice activity
            confidence -= 0.05
        
        # Semantic quality (±0.10)
        transcript = semantic_result.get('transcript', '')
        if len(transcript) > 50:  # Substantial content
            confidence += 0.10
        elif len(transcript) < 10:  # Very little content
            confidence -= 0.10
        
        # Clamp to [0, 1]
        return max(0.0, min(1.0, confidence))
    
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
