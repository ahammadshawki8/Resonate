# AI-Powered Insights Testing Guide

## Overview
Your Resonate app now has AI-powered personalized insights using Groq AI (llama-3.3-70b-versatile model). The system analyzes your voice entry patterns and generates personalized advice.

## How It Works

### Insight Generation Triggers
Insights are automatically generated when you reach these milestones:
- ✅ **1st entry** - Welcome and encouragement
- ✅ **3rd entry** - Early pattern recognition
- ✅ **7th entry** - Weekly summary
- ✅ **Every 5th entry** - Regular check-ins (10th, 15th, 20th, etc.)
- ✅ **Low mood** - When mood score < 30% (support and suggestions)
- ✅ **High mood** - When mood score ≥ 80% (celebration and maintenance)

### What Gets Analyzed
The AI looks at:
- Your mood scores over time
- Detected emotions (joy, sadness, stress, calm, etc.)
- Mood trends (improving, declining, stable)
- Recent transcripts (what you've been talking about)
- Entry frequency and patterns

## Testing Steps

### 1. Record Your First Entry
1. Open the app on your phone
2. Tap the microphone button
3. Speak for 10-30 seconds about how you're feeling
4. Wait for analysis to complete
5. Save the entry
6. **Check the Insights tab** - You should see your first AI-generated insight!

### 2. Record More Entries
Record at least 3-7 entries over time to see different types of insights:
- Try different moods (happy, sad, stressed, calm)
- Talk about different topics (work, family, health, goals)
- Record at different times of day

### 3. Check Insights Tab
After each milestone (1st, 3rd, 7th entry), check the Insights tab:
- Tap the "Insights" icon in the bottom navigation
- You should see personalized insights with:
  - AI-generated advice specific to your patterns
  - Encouragement and support
  - Actionable suggestions
  - Trend analysis

## What to Expect

### Example Insights

**After 1st Entry:**
> "🎉 Great start! You've completed your first voice check-in. I noticed you're feeling [emotion]. This is a wonderful step toward understanding your emotional patterns. Keep checking in regularly to unlock deeper insights about your well-being."

**After 3rd Entry (Positive Trend):**
> "📈 You're building great momentum! Over your last 3 check-ins, I've noticed your mood has been improving. You've mentioned [topics] frequently. Consider maintaining this positive trend by [specific suggestion]."

**Low Mood Detection:**
> "💙 I notice you're going through a challenging time. Your recent check-ins show [pattern]. Remember, it's okay to feel this way. Here are some things that might help: [personalized suggestions based on your history]."

## Monitoring AI Insights

### Check Python Logs
To see when insights are generated, watch the Python service logs:
```powershell
# The logs will show:
# - "Generating insight for X entries"
# - "Generated AI insight: [type]"
# - Groq API calls and responses
```

### Insight Types
- `achievement` - Milestone celebrations (1st entry, improvements)
- `weekly_summary` - Regular summaries (7th entry, etc.)
- `pattern_alert` - When concerning patterns detected
- `tip` - General wellness advice

## Privacy & Data

### What Gets Sent to Groq AI
- Mood scores (numbers only)
- Detected emotions (keywords)
- Transcripts (only last 2-3 entries, truncated to 150 chars each)
- Entry count and timestamps

### What Does NOT Get Sent
- Your name or personal information
- Audio files
- Full conversation history
- Location data

### Privacy Levels
Your privacy settings affect what data is available for insights:
- **Full**: All data available for best insights
- **Context**: No full transcripts, but emotions and mood
- **Keywords**: Only emotion keywords
- **Acoustic**: Only voice tone data (no transcripts)

## Troubleshooting

### No Insights Appearing?
1. Make sure you've reached a milestone (1st, 3rd, 7th entry)
2. Check Python logs for errors
3. Verify Groq API key is configured in `.env`
4. Try recording another entry

### Insights Not Personalized?
- Record more entries (need at least 3 for good patterns)
- Vary your topics and moods
- Speak for longer (20-30 seconds minimum)

### API Errors?
- Check your Groq API key is valid
- Verify internet connection
- Check Groq API rate limits (14,400 requests/day on free tier)

## Current Status

✅ **All Systems Operational**
- Python AI Service: Running on port 8001
- Whisper Transcription: Real (base model)
- Groq AI: Configured and ready
- Insight Generator: Loaded and functional

## Next Steps

1. **Test it now!** Record your first voice entry
2. Check the Insights tab after saving
3. Record 2 more entries to see pattern recognition
4. Try different moods to see how insights adapt
5. Share feedback on insight quality and relevance

---

**Note**: Insights are generated in the background and may take a few seconds. If you don't see an insight immediately, refresh the Insights tab or record another entry.

**Groq API**: Free tier provides 14,400 requests per day (no credit card required). Each insight generation uses 1 request.
