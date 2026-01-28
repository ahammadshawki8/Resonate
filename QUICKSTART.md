# 🚀 Resonate - Quick Start Guide

## Prerequisites
- Flutter 3.x
- Dart 3.8+
- Python 3.10+
- Docker Desktop
- Chrome browser

---

## Setup (One Time - 5 Minutes)

### 1. Python Dependencies
```powershell
cd resonate_python
pip install -r requirements.txt
python -c "import nltk; nltk.download('punkt'); nltk.download('vader_lexicon')"
```

### 2. Add Groq API Key
Edit `resonate_python/.env` and add your key:
```
GROQ_API_KEY=your_key_here
```
Get free key at: https://console.groq.com/keys (no credit card needed)

---

## Start Application (4 Terminals)

### Terminal 1: Database
```powershell
cd resonate_server\resonate_server_server
docker-compose up
```
✅ Wait for: `database system is ready to accept connections`

### Terminal 2: Serverpod Backend
```powershell
cd resonate_server\resonate_server_server
docker restart resonate_postgres
timeout /t 5
dart bin\main.dart --apply-migrations
```
✅ Wait for: `Server 'resonate_server' listening on port 8080`

### Terminal 3: Python AI Service
```powershell
cd resonate_python
python app.py
```
✅ Wait for: `Running on http://0.0.0.0:8001`

### Terminal 4: Flutter App
```powershell
cd resonate_flutter
flutter run -d chrome
```
✅ Chrome opens automatically

---

## Test the App

1. **Sign Up**: Click "Sign Up", enter name/email/password
2. **Verify**: Check Terminal 2 for 6-digit code, enter it
3. **Record**: Click microphone, speak 5-15 seconds, click stop
4. **View Results**: See mood analysis, check calendar & analytics

---

## Services Running

- PostgreSQL: localhost:5432 (password: mysecretpassword)
- Redis: localhost:6379 (password: myredispassword)
- Serverpod API: localhost:8080
- Python AI: localhost:8001
- Flutter App: Chrome

---

## Stop Everything

- Terminal 1: `Ctrl+C` then `docker-compose down`
- Terminal 2-4: `Ctrl+C`

---

## Troubleshooting

**Database connection fails:**
```powershell
docker restart resonate_postgres
timeout /t 5
```

**Python errors:**
```powershell
pip install -r requirements.txt
```

**Flutter on Windows:**
Use Chrome: `flutter run -d chrome`

---

## Architecture

```
Flutter (Chrome) → Serverpod (8080) → Python AI (8001)
                         ↓
                   PostgreSQL (5432)
```

**Features:**
- Multi-modal voice analysis (acoustic + semantic)
- English + Bengali support
- 4 privacy levels
- AI-powered insights
- Mood tracking & analytics
- Wellness tools

---

**Status**: ✅ Complete & Functional
**Documentation**: See `README.md` and `backendplanning.md`
