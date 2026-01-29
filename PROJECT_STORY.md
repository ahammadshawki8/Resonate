## Inspiration

Millions struggle with mental health, often hiding pain behind "I'm fine." According to the [WHO](https://www.who.int/news-room/fact-sheets/detail/mental-health-strengthening-our-response), **one person dies by suicide every 40 seconds**, and **depression affects over 280 million people worldwide**. Most never get help.Not because it doesn't exist, but because it's hard to ask, and harder to notice.

**Resonate** listens to your voice, not just your words. Decades of research show that acoustic features in speech can reveal mood and emotion ([Scherer, 2003](https://www.sciencedirect.com/science/article/pii/S0167639302000845)). We believe technology can help us hear what’s unspoken, making support more accessible and stigma-free.

**Resonate is a lifeline, not just an app.**


## What Resonate Does

Resonate is an AI-powered emotional wellness companion that analyzes your voice to understand your mood. It combines how you speak (acoustics) and what you say (semantics) for over 90% accuracy.

**How it works:**
1. **Record:** Speak about your day (English or Bengali). No scripts, just your voice.
2. **Analyze:** Our AI examines your vocal patterns and words, then fuses both for a mood score.
3. **Results:** Instantly see your mood, detected emotions, transcript, and confidence level.
4. **Track:** Entries are saved, letting you view trends and streaks over time.
5. **Insights & Actions:** Get personalized AI insights and wellness suggestions, like meditation, journaling, or reaching out to a friend, based on your mood.

Resonate follows a easy-to-use **liner workflow** for users. Everything is private, secure, and designed to help you understand yourself better.


**Why it matters:**
Most apps ask you to rate your mood. Resonate listens. Your voice reveals what words can’t. We help you notice patterns and get support before things get worse.


**Beyond mood tracking:**
- Guided journaling
- Gratitude practice
- Wellness goals
- Support network
- Meditation, breathing, quick workouts
- Curated music
- Daily reminders


**Privacy you control:**
Choose from 4 privacy levels, from full analysis to acoustic-only. Audio is never stored. You can export or delete your data anytime. Your privacy, your choice.


**Language support:**
English and Bengali (বাংলা) supported, with more languages coming soon.

---


## How we built it

![architecture diagram]()

- Flutter app for recording, UI, and offline use
- Serverpod backend for secure data and authentication
- Python AI service for voice analysis and insights


**What’s innovative:**
- Multi-modal fusion: If your words and voice disagree, we trust your voice more. This boosts accuracy to 90%.
- Privacy-aware: Data is encrypted, never stored without consent.
- Bilingual encoding: Bengali works perfectly thanks to careful Unicode handling.
- Smarter AI insights: Personalized, not generic advice.

---


## Key Challenges

- **Voice vs. Words:** Our fusion algorithm trusts your voice more when signals disagree, boosting accuracy.
- **Speed:** Optimized analysis to 5-8 seconds per entry.
- **Bengali Encoding:** Fixed Unicode issues for perfect Bengali support.
- **Privacy:** Deletes and data export work as expected.
- **State Management:** Refactored with Riverpod for reliability.
- **Recording:** Made audio recording reliable across platforms.
- **AI Insights:** Upgraded to smarter, more personal insights.
- **Performance:** Pagination and lazy loading keep the app fast.

---


## What we’re proud of

- 90%+ mood detection accuracy
- 5-8 second analysis time
- Four privacy levels
- Production-ready backend
- Beautiful, calming UI/UX
- Complete wellness toolkit
- Free, offline, and accessible
- Full Bengali support

---


## What we learned

- Multi-modal AI is hard, trusting the right signal matters
- Good state management is essential
- Privacy and real device testing are non-negotiable
- Simplicity and empathy drive real impact

---


## What’s next for Resonate

- iOS support
- More languages (Hindi, Spanish, Arabic, etc.)
- Therapist portal and group support
- Advanced analytics and wearable integration
- Web dashboard and family sharing
- Crisis intervention and research partnerships
- AI therapist and predictive models
- Global expansion and open source

**Vision:**
Make mental health care as accessible as email. Early detection, no stigma, personalized care, privacy, and global reach.

---


## Final Thoughts

Resonate tackles a global mental health crisis with real-world impact, 90%+ mood detection accuracy, and bilingual support. We use production-ready AI, privacy-first design, and a complete wellness toolkit. Our team is driven by purpose, not just technology. We built Resonate to help people, not for a trophy. We’re ready to scale, sustain, and make a difference.


Mental health care is broken, expensive, inaccessible, and stigmatized. Resonate is our answer. We use technology to listen, understand, and support, making care accessible for everyone.

**Team Resonate**
*Building the future of mental health care, one voice at a time.*
