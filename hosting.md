# 🌐 Hosting Resonate: Free Deployment Guide

This guide explains how to host all three components of your Resonate app (Flutter frontend, Serverpod backend, Python AI service) using free hosting services, so anyone can use your app without paid infrastructure.

---

## 1. Host the Flutter Web App (Frontend)

### Option A: GitHub Pages (Free, for Web)
1. **Build the Flutter web app:**
   ```bash
   cd resonate_flutter
   flutter build web
   ```
2. **Push the `build/web` folder to a `gh-pages` branch:**
   - Install [gh-pages](https://www.npmjs.com/package/gh-pages) globally (requires Node.js):
     ```bash
     npm install -g gh-pages
     ```
   - Deploy:
     ```bash
     gh-pages -d build/web
     ```
   - Or use the [GitHub Pages action](https://github.com/marketplace/actions/deploy-to-github-pages) in your repo.
3. **Set your repo's GitHub Pages source to `gh-pages` branch.**
4. **Access your app at:**
   `https://<your-username>.github.io/<repo-name>/`

### Option B: Netlify (Free, for Web)
1. **Sign up at [Netlify](https://netlify.com)**
2. **Connect your GitHub repo**
3. **Set build command:**
   ```bash
   flutter build web
   ```
   and publish directory: `build/web`
4. **Deploy!**

---

## 2. Host the Serverpod Backend (API)

### Option A: Render.com (Free Tier, Backend in Subfolder)
1. **Sign up at [Render](https://render.com)**
2. **Create a new PostgreSQL Database:**
   - In Render, click "New +" → "PostgreSQL"
   - Name your database (e.g., resonate-db)
   - Wait for Render to provision the DB and note the connection details (host, user, password, database, port)
3. **Create a new Web Service for Serverpod Backend:**
   - Click "New +" → "Web Service"
   - Connect your GitHub repo
   - In the "Root Directory" field, enter `resonate_server` (since your backend is in a subfolder)
   - Set build command:
     ```bash
     dart pub get
     ```
   - Set start command:
     ```bash
     dart bin/main.dart
     ```
   - Choose a free instance type
4. **Configure Database Connection:**
   - In your Render Web Service, go to "Environment" and add environment variables for your DB credentials (or edit `config/passwords.yaml` and `config/config.yaml` in your repo to use the Render DB info)
   - Example environment variables:
     - `DB_HOST`, `DB_PORT`, `DB_USER`, `DB_PASSWORD`, `DB_NAME`
   - Or directly update your config files with the Render DB details
5. **Redis:**
   - Use [Upstash](https://upstash.com) for free Redis (or Render's Redis if available)
   - Update your config with the Upstash Redis URL
6. **Other Environment Variables:**
   - Set any required env vars in Render's dashboard
7. **Deploy!**
   - Render will build and deploy your backend from the resonate_server subfolder, connected to the Render-hosted PostgreSQL database.

### Option B: Railway.app (Free Tier)
1. **Sign up at [Railway](https://railway.app)**
2. **Create a new project, add your repo**
3. **Add PostgreSQL and Redis plugins**
4. **Set up build/start commands as above**
5. **Deploy!**

---

## 3. Host the Python AI Service (Flask)

### Option A: Render.com (Free Web Service)
1. **Create a new Web Service**
   - Connect your repo or upload code
   - Set build command:
     ```bash
     pip install -r requirements.txt
     ```
   - Set start command:
     ```bash
     python app.py
     ```
   - Set environment variables (GROQ_API_KEY, etc.)
   - Choose a free instance type
2. **Deploy!**

### Option B: Railway.app (Free Service)
1. **Create a new service, add your Python code**
2. **Set up build/start commands as above**
3. **Set environment variables**
4. **Deploy!**

---

## 4. Connect All Services
- Update your Flutter app's API URLs to:
   - Serverpod backend: https://resonate-vucn.onrender.com
   - Python AI service: https://resonate-1.onrender.com
- Make sure CORS is enabled on your backend and Python services
- Test all endpoints from your deployed frontend

---

## 5. Tips & Limitations
- Free hosting services may sleep after inactivity (cold start delays)
- Free DBs have storage and connection limits
- For production, consider paid plans for reliability
- Always secure your API keys and sensitive data

---

## 6. Useful Links
- [Flutter Web Deployment](https://docs.flutter.dev/deployment/web)
- [Serverpod Deployment Guide](https://docs.serverpod.dev/deployment/)
- [Render.com Docs](https://render.com/docs)
- [Railway.app Docs](https://docs.railway.app/)
- [Neon Free Postgres](https://neon.tech)
- [Upstash Free Redis](https://upstash.com)
- [Supabase Free Postgres](https://supabase.com)

---

**With these steps, you can host your entire Resonate stack for free and share your app with the world!**
