# AI Insights - Complete Guide

## Overview
Resonate uses Groq AI (llama-3.3-70b-versatile) to generate personalized insights based on your voice entry patterns. Insights are now **saved to the database** and persist across sessions.

## Insight Types

### 1. **Achievement** 🎉
**When Generated:**
- First entry (milestone celebration)
- Improving mood trend detected
- Reaching entry milestones (3rd, 7th, 10th, etc.)

**Purpose:**
- Celebrate progress and milestones
- Encourage continued engagement
- Recognize positive patterns

**Example:**
> "🎉 Congratulations on your first voice check-in! This is a wonderful step toward understanding your emotional patterns. Consistency is key - try to check in daily to unlock deeper insights about your well-being."

**AI Analysis:**
- Entry count and frequency
- Mood improvement trends
- Consistency patterns

---

### 2. **Weekly Summary** 📊
**When Generated:**
- Every 7th entry
- After 7+ days of consistent check-ins
- When enough data exists for pattern analysis

**Purpose:**
- Provide overview of emotional patterns
- Highlight trends over time
- Offer data-driven observations

**Example:**
> "📊 You've completed 7 check-ins this week! Your mood has been trending upward, with an average score of 72%. You've mentioned 'work' and 'family' frequently. Your emotional balance is improving - keep maintaining this positive momentum!"

**AI Analysis:**
- Average mood score over period
- Mood trend (improving/declining/stable)
- Common topics and themes
- Emotional patterns
- Frequency of check-ins

---

### 3. **Pattern Alert** ⚠️
**When Generated:**
- Declining mood trend detected
- Low mood (<30%) for multiple entries
- Concerning emotional patterns
- Significant mood drops

**Purpose:**
- Provide supportive intervention
- Suggest helpful resources
- Encourage self-care actions
- Offer empathetic guidance

**Example:**
> "💙 I've noticed your mood has been lower than usual over the past few check-ins. You've mentioned feeling 'stressed' and 'overwhelmed' frequently. Remember, it's okay to ask for help. Consider: 1) Talking to someone you trust, 2) Taking a break for self-care, 3) Trying a breathing exercise."

**AI Analysis:**
- Recent mood scores
- Mood decline rate
- Emotional keywords (stress, anxiety, sadness)
- Transcript content analysis
- Pattern duration

---

### 4. **Tip** 💡
**When Generated:**
- Regular check-ins (every 5th entry)
- Neutral mood patterns
- When no specific alerts needed
- General wellness guidance

**Purpose:**
- Provide actionable wellness advice
- Suggest new features or exercises
- Maintain engagement
- Offer general support

**Example:**
> "💡 You're building a great habit with regular check-ins! Your mood has been stable around 60%. To enhance your emotional awareness, try: 1) Recording at different times of day, 2) Using the breathing exercise when stressed, 3) Adding tags to track patterns."

**AI Analysis:**
- Entry consistency
- Mood stability
- Feature usage patterns
- Time of day patterns

---

## Generation Triggers

### Milestone-Based
- **1st entry**: Welcome and encouragement
- **3rd entry**: Early pattern recognition
- **7th entry**: Weekly summary
- **Every 5th entry**: Regular tips (10th, 15th, 20th, 25th...)

### Mood-Based
- **Low mood (<30%)**: Pattern alert with support
- **High mood (≥80%)**: Achievement celebration
- **Declining trend**: Pattern alert
- **Improving trend**: Achievement recognition

### Time-Based
- After 7+ days: Weekly summary
- After 30+ days: Monthly reflection (future feature)

---

## What AI Analyzes

### 1. Mood Scores
- Current mood score (0-100%)
- Average mood over time
- Recent mood (last 3 entries)
- Mood range (variability)
- Trend direction (improving/declining/stable)

### 2. Emotions
- Detected emotions (joy, sadness, stress, calm, etc.)
- Emotion intensity levels
- Common emotion patterns
- Emotion combinations
- Emotional diversity

### 3. Transcripts
- Recent transcripts (last 2-3 entries)
- Common topics and themes
- Keywords and phrases
- Sentiment analysis
- Context understanding

### 4. Patterns
- Entry frequency
- Time of day patterns
- Consistency
- Mood volatility
- Emotional trends

---

## Privacy & Data

### What Gets Sent to Groq AI
✅ **Sent:**
- Mood scores (numbers only)
- Detected emotions (keywords)
- Truncated transcripts (last 150 chars of recent entries)
- Entry timestamps
- Entry count

❌ **NOT Sent:**
- Your name or personal information
- Full conversation history
- Audio files
- Location data
- Contact information

### Privacy Level Impact
Your privacy settings affect insight quality:

**Full Privacy:**
- Best insights (all data available)
- Transcript analysis included
- Most personalized advice

**Context Privacy:**
- Good insights (emotions + mood)
- No full transcripts
- Topic-based analysis

**Keywords Privacy:**
- Basic insights (emotions only)
- Limited personalization
- Emotion-focused advice

**Acoustic Privacy:**
- Minimal insights (mood only)
- No transcript analysis
- General wellness tips

---

## Database Storage

### How Insights Are Saved
1. **Generated**: AI creates insight via Python service
2. **Local State**: Added to app immediately (instant display)
3. **Database**: Saved to PostgreSQL via Serverpod
4. **Persistence**: Available after logout/login
5. **Sync**: Fetched on app start if authenticated

### Insight Data Structure
```dart
Insight {
  id: String (unique identifier)
  userId: String (your user ID)
  insightText: String (AI-generated advice)
  insightType: String (achievement/tip/pattern_alert/weekly_summary)
  generatedAt: DateTime (when created)
  isRead: bool (read status)
}
```

---

## Insight Quality Factors

### High-Quality Insights Require:
1. **Multiple entries** (3+ for patterns)
2. **Varied moods** (different emotional states)
3. **Detailed transcripts** (speak for 20-30+ seconds)
4. **Consistency** (regular check-ins)
5. **Full privacy** (more data = better insights)

### Tips for Better Insights:
- ✅ Record daily or regularly
- ✅ Speak naturally for 20-30 seconds
- ✅ Vary your topics (work, family, health, etc.)
- ✅ Use full privacy mode
- ✅ Be honest about your feelings
- ✅ Record at different times of day

---

## Groq AI Details

### Model
- **Name**: llama-3.3-70b-versatile
- **Provider**: Groq
- **Type**: Large Language Model (70B parameters)
- **Specialization**: Conversational AI, empathetic responses

### API Limits
- **Free Tier**: 14,400 requests/day
- **Cost**: Free (no credit card required)
- **Rate**: 1 request per insight
- **Speed**: ~2-3 seconds per insight

### Prompt Engineering
The AI is instructed to:
- Be empathetic and supportive
- Provide actionable advice
- Keep insights under 150 words
- Be specific to user patterns
- Use warm, encouraging language
- Avoid medical/clinical advice

---

## Troubleshooting

### Insights Not Appearing?
1. ✅ Check you've reached a milestone (1st, 3rd, 7th entry)
2. ✅ Verify internet connection (Groq API needs internet)
3. ✅ Check Python service logs for errors
4. ✅ Ensure Groq API key is configured
5. ✅ Try recording another entry

### Insights Not Persisting After Logout?
1. ✅ Verify you're logged in (not demo mode)
2. ✅ Check Serverpod backend is running
3. ✅ Restart Serverpod to load new endpoint
4. ✅ Check database connection

### Insights Not Personalized?
1. ✅ Record more entries (need 3+ for patterns)
2. ✅ Vary your moods and topics
3. ✅ Speak for longer (20-30 seconds)
4. ✅ Use full privacy mode
5. ✅ Check in regularly

### Generic Insights?
- **Cause**: Not enough data or patterns
- **Solution**: Record 5-7 entries with varied content
- **Note**: First few insights are naturally more generic

---

## Future Enhancements

### Planned Features:
- 📅 **Monthly reflections** (after 30+ entries)
- 🎯 **Goal-based insights** (track specific goals)
- 📈 **Trend predictions** (forecast mood patterns)
- 🤝 **Comparative insights** (compare to past periods)
- 🎨 **Personalized recommendations** (activities, exercises)
- 🔔 **Proactive alerts** (before mood drops)

---

## Example Insight Flow

### Day 1 - First Entry
**Mood**: 65% (neutral-positive)
**Emotions**: Calm, hopeful
**Transcript**: "Feeling okay today, work was busy but manageable..."

**Generated Insight** (Achievement):
> "🎉 Welcome to Resonate! You've taken the first step toward better emotional awareness. Your mood today is balanced at 65%, and I sense calmness and hope in your voice. Keep checking in daily to discover patterns and insights about your well-being!"

---

### Day 3 - Third Entry
**Mood**: 72% (positive)
**Emotions**: Joy, energetic
**Transcript**: "Had a great day! Finished my project and went for a run..."

**Generated Insight** (Achievement):
> "📈 You're building momentum! Over 3 check-ins, your mood has improved from 65% to 72%. You've mentioned 'work' and 'exercise' - both positive influences. Your energy is rising. Keep this up!"

---

### Day 7 - Seventh Entry
**Mood**: 58% (neutral)
**Emotions**: Tired, stressed
**Transcript**: "Long week, feeling exhausted. Too much on my plate..."

**Generated Insight** (Weekly Summary):
> "📊 Week complete! You've checked in 7 times. Your average mood is 68% - generally positive. However, I notice you're feeling tired today after a busy week. You've mentioned 'work' frequently. Consider: 1) Taking breaks, 2) Trying a breathing exercise, 3) Prioritizing rest this weekend."

---

## Summary

**Insights are:**
- ✅ AI-powered (Groq llama-3.3-70b)
- ✅ Personalized to your patterns
- ✅ Saved to database (persist after logout)
- ✅ Privacy-aware (respects your settings)
- ✅ Actionable (provide specific advice)
- ✅ Empathetic (supportive tone)

**To get the best insights:**
1. Record regularly (daily is ideal)
2. Speak naturally for 20-30 seconds
3. Use full privacy mode
4. Vary your topics and moods
5. Be consistent for 7+ days

---

**Last Updated**: 2026-01-28
**Version**: 1.0
**AI Model**: Groq llama-3.3-70b-versatile
