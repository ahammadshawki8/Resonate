# Resonate Server (Serverpod Backend)

## Overview
This is the Serverpod backend for the Resonate platform, providing all data, authentication, and business logic for the Resonate Flutter app. The backend is built with Serverpod 3.2.3 and uses PostgreSQL and Redis for data storage and caching.

## Key Features
- **User Authentication**: Secure email/password authentication using Serverpod's identity provider system
- **API for All Data Types**: Endpoints for voice entries, insights, tags, mood patterns, user settings, and more
- **Real-Time Data**: All app data is served to the Flutter frontend via generated client code
- **No Dummy Data**: All data is persisted in the backend database; the frontend does not use any mock or local data
- **Extensible Architecture**: Easily add new endpoints, models, and business logic as needed

## Project Structure
- `lib/`
  - `src/`: All Serverpod endpoint implementations and business logic
  - `generated/`: Serverpod-generated code (do not edit manually)
  - `models/`: Data models for all entities (UserProfile, VoiceEntry, Insight, Tag, MoodPattern, UserSettings, etc.)
- `config/`: Server and database configuration files
- `docker/`: Docker setup for PostgreSQL and Redis

## Major Refactor Summary
- **All endpoints implemented** for user, voice entry, insight, tag, mood pattern, and user settings management
- **Authentication logic** is handled by Serverpod's identity provider
- **No dummy or mock data**: All data is stored in PostgreSQL and accessed via Serverpod endpoints
- **Client code generated** for use in the Flutter frontend (`resonate_server_client`)

## How to Run
1. Ensure Docker is running (for PostgreSQL and Redis)
2. Start the backend server:
   ```sh
   cd resonate_server
   serverpod run
   ```
3. The server will be available at `http://localhost:8080` by default
4. Generate client code for the Flutter app if needed:
   ```sh
   serverpod generate client
   ```

## API & Client Integration
- All API endpoints are documented in the `lib/src/` directory
- The Flutter app uses the generated `resonate_server_client` package for all backend communication

## Notes
- For frontend integration and usage, see the `README.md` in the `resonate_flutter` directory
- For advanced configuration, see the Serverpod documentation

---
For issues, contributions, or questions, please refer to the repository guidelines or contact the maintainers.
