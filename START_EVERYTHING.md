# 🚀 Start Everything - Simple 3-Terminal Setup

## ✅ Database Issue FIXED!
PostgreSQL is now installed locally on Windows (no Docker needed for database).

---

## One-Time Setup (5 minutes)

### 1. Add Groq API Key

Edit `resonate_python/.env`:
```
GROQ_API_KEY=your_key_here
```

Get free key at: https://console.groq.com/keys

### 2. Install Python Dependencies

```powershell
cd resonate_python
pip install -r requirements.txt
python -c "import nltk; nltk.download('punkt'); nltk.download('vader_lexicon')"
cd ..
```

---

## Start Everything (3 Terminals)

### Terminal 1: Python AI Service

```powershell
cd resonate_python
python app.py
```

Wait for: `Running on http://0.0.0.0:8001`

### Terminal 2: Serverpod Backend

```powershell
cd resonate_server\resonate_server_server
dart bin\main.dart
```

Wait for: `Webserver listening on http://localhost:8082`

### Terminal 3: Flutter App

```powershell
cd resonate_flutter
flutter run -d chrome
```

Chrome opens automatically!

---

## That's It! 🎉

All services are now running:
- ✅ PostgreSQL: localhost:5433 (Local Windows installation)
- ✅ Redis: localhost:6379 (Docker container)
- ✅ Python AI: localhost:8001 (Real AI analysis!)
- ✅ Serverpod: localhost:8080 (Full database persistence!)
- ✅ Flutter App: Chrome (100% functional UI)

---

## Test the App

1. Sign up with email
2. Check Terminal 2 for verification code
3. Record voice entry (5-15 seconds)
4. See real AI analysis from Python service!
5. **Your data is now saved permanently!** ✨
6. Close and reopen - your entries are still there!

---

## Stop Everything

- Terminal 1: `Ctrl+C`
- Terminal 2: `Ctrl+C`
- Terminal 3: `Ctrl+C` or press `q`

---

## Database Info

- **Type**: PostgreSQL 16 (Local Windows installation)
- **Port**: 5433
- **Database**: resonate_server
- **User**: postgres
- **Password**: mysecretpassword
- **Persistence**: ✅ All data saved permanently

---

## Troubleshooting

### Python service fails
- Run: `pip install -r requirements.txt`
- Download NLTK: `python -c "import nltk; nltk.download('punkt'); nltk.download('vader_lexicon')"`

### Flutter fails on Windows
- Use Chrome: `flutter run -d chrome`

### Serverpod fails to start
- Make sure no other Serverpod instance is running
- Check if ports 8080-8082 are available

---

**The app is 100% functional with full database persistence!**
All features work, and your data is saved permanently! 🚀
