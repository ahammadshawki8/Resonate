"""
AI-Powered Insight Generator using Groq
Generates personalized insights based on user's voice entry patterns
"""

import logging
from typing import List, Dict, Any
from groq import Groq
import os

logger = logging.getLogger(__name__)


class InsightGenerator:
    """Generates personalized insights using Groq AI"""
    
    def __init__(self):
        """Initialize Groq client"""
        try:
            self.client = Groq()
            logger.info("Insight generator initialized with Groq AI")
        except Exception as e:
            logger.warning(f"Groq client initialization failed: {e}")
            self.client = None
    
    def generate_insight(self, entries: List[Dict[str, Any]]) -> Dict[str, Any]:
        """
        Generate personalized insight based on user's voice entries
        
        Args:
            entries: List of voice entry data with mood scores, transcripts, emotions
            
        Returns:
            Dictionary with insight text, type, and metadata
        """
        if not self.client:
            return self._fallback_insight(entries)
        
        try:
            # Prepare context from entries
            context = self._prepare_context(entries)
            
            # Generate insight using Groq
            prompt = self._build_prompt(context)
            
            response = self.client.chat.completions.create(
                model="llama-3.3-70b-versatile",
                messages=[
                    {
                        "role": "system",
                        "content": "You are an empathetic emotional wellness coach. Analyze the user's voice check-in patterns and provide a brief, supportive, and actionable insight. Keep it under 150 words. Be warm, encouraging, and specific to their patterns."
                    },
                    {
                        "role": "user",
                        "content": prompt
                    }
                ],
                temperature=0.7,
                max_tokens=200,
            )
            
            insight_text = response.choices[0].message.content.strip()
            insight_type = self._determine_insight_type(context)
            
            logger.info(f"Generated AI insight: {insight_type}")
            
            return {
                'insight_text': insight_text,
                'insight_type': insight_type,
                'confidence': 0.9,
                'generated_by': 'groq_ai'
            }
            
        except Exception as e:
            logger.error(f"Error generating AI insight: {str(e)}")
            return self._fallback_insight(entries)
    
    def _prepare_context(self, entries: List[Dict[str, Any]]) -> Dict[str, Any]:
        """Prepare context summary from entries"""
        if not entries:
            return {'entry_count': 0}
        
        # Calculate statistics
        mood_scores = [e.get('final_mood_score', 0.5) for e in entries]
        avg_mood = sum(mood_scores) / len(mood_scores)
        
        # Get recent trend (last 3 vs previous)
        recent_avg = sum(mood_scores[:3]) / min(3, len(mood_scores))
        previous_avg = sum(mood_scores[3:6]) / max(1, min(3, len(mood_scores) - 3)) if len(mood_scores) > 3 else avg_mood
        trend = 'improving' if recent_avg > previous_avg + 0.1 else 'declining' if recent_avg < previous_avg - 0.1 else 'stable'
        
        # Collect emotions
        all_emotions = []
        for entry in entries[:5]:  # Last 5 entries
            all_emotions.extend(entry.get('detected_emotions', []))
        
        # Get transcripts (if available)
        transcripts = [e.get('transcript', '') for e in entries[:3] if e.get('transcript')]
        
        return {
            'entry_count': len(entries),
            'avg_mood': avg_mood,
            'recent_mood': recent_avg,
            'trend': trend,
            'common_emotions': list(set(all_emotions))[:5],
            'recent_transcripts': transcripts,
            'mood_range': max(mood_scores) - min(mood_scores),
        }
    
    def _build_prompt(self, context: Dict[str, Any]) -> str:
        """Build prompt for Groq"""
        entry_count = context['entry_count']
        avg_mood = context['avg_mood']
        trend = context['trend']
        emotions = ', '.join(context['common_emotions'][:3]) if context['common_emotions'] else 'mixed'
        
        mood_desc = 'positive' if avg_mood >= 0.6 else 'neutral' if avg_mood >= 0.4 else 'challenging'
        
        prompt = f"""Analyze this user's emotional wellness patterns:

- Total check-ins: {entry_count}
- Average mood: {mood_desc} ({avg_mood:.2f}/1.0)
- Recent trend: {trend}
- Common emotions: {emotions}
"""
        
        if context['recent_transcripts']:
            prompt += f"\nRecent thoughts:\n"
            for i, transcript in enumerate(context['recent_transcripts'][:2], 1):
                if transcript and len(transcript) > 20:
                    prompt += f"{i}. {transcript[:150]}...\n"
        
        prompt += "\nProvide a brief, personalized insight with specific advice or encouragement."
        
        return prompt
    
    def _determine_insight_type(self, context: Dict[str, Any]) -> str:
        """Determine the type of insight based on context"""
        entry_count = context['entry_count']
        trend = context['trend']
        avg_mood = context['avg_mood']
        
        if entry_count == 1:
            return 'achievement'
        elif entry_count % 7 == 0:
            return 'weekly_summary'
        elif trend == 'declining' and avg_mood < 0.4:
            return 'pattern_alert'
        elif trend == 'improving':
            return 'achievement'
        else:
            return 'tip'
    
    def _fallback_insight(self, entries: List[Dict[str, Any]]) -> Dict[str, Any]:
        """Fallback insight when AI is unavailable"""
        entry_count = len(entries)
        
        if entry_count == 1:
            text = "🎉 Great start! You've completed your first voice check-in. Consistency is key to understanding your emotional patterns."
        elif entry_count < 5:
            text = f"🔥 You're building momentum with {entry_count} check-ins! Keep going to unlock deeper insights."
        else:
            mood_scores = [e.get('final_mood_score', 0.5) for e in entries]
            avg_mood = sum(mood_scores) / len(mood_scores)
            text = f"📊 You've completed {entry_count} check-ins. Your average mood has been {'positive' if avg_mood >= 0.6 else 'balanced' if avg_mood >= 0.4 else 'challenging'}. Keep checking in regularly!"
        
        return {
            'insight_text': text,
            'insight_type': 'achievement',
            'confidence': 0.5,
            'generated_by': 'fallback'
        }
