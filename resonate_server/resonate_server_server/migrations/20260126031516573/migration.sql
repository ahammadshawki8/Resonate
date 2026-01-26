BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "entry_tags" (
    "id" bigserial PRIMARY KEY,
    "voiceEntryId" bigint NOT NULL,
    "tagId" bigint NOT NULL
);

-- Indexes
CREATE INDEX "entry_tag_entry_idx" ON "entry_tags" USING btree ("voiceEntryId");
CREATE INDEX "entry_tag_tag_idx" ON "entry_tags" USING btree ("tagId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "favorite_contacts" (
    "id" bigserial PRIMARY KEY,
    "userProfileId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "name" text NOT NULL,
    "emoji" text NOT NULL,
    "type" text NOT NULL,
    "phone" text
);

-- Indexes
CREATE INDEX "contact_user_idx" ON "favorite_contacts" USING btree ("userProfileId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "gratitude_entries" (
    "id" bigserial PRIMARY KEY,
    "userProfileId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "items" json NOT NULL
);

-- Indexes
CREATE INDEX "gratitude_user_idx" ON "gratitude_entries" USING btree ("userProfileId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "insights" (
    "id" bigserial PRIMARY KEY,
    "userProfileId" bigint NOT NULL,
    "insightText" text NOT NULL,
    "insightType" text NOT NULL,
    "generatedAt" timestamp without time zone NOT NULL,
    "isRead" boolean NOT NULL,
    "relatedEntryIds" json
);

-- Indexes
CREATE INDEX "insight_user_idx" ON "insights" USING btree ("userProfileId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "journal_entries" (
    "id" bigserial PRIMARY KEY,
    "userProfileId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "content" text NOT NULL,
    "prompt" text NOT NULL,
    "moodAtTime" text
);

-- Indexes
CREATE INDEX "journal_user_idx" ON "journal_entries" USING btree ("userProfileId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "mood_patterns" (
    "id" bigserial PRIMARY KEY,
    "userProfileId" bigint NOT NULL,
    "patternType" text NOT NULL,
    "description" text NOT NULL,
    "confidence" double precision NOT NULL,
    "detectedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "pattern_user_idx" ON "mood_patterns" USING btree ("userProfileId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "tags" (
    "id" bigserial PRIMARY KEY,
    "userProfileId" bigint NOT NULL,
    "name" text NOT NULL,
    "color" text NOT NULL,
    "usageCount" bigint NOT NULL
);

-- Indexes
CREATE INDEX "tag_user_idx" ON "tags" USING btree ("userProfileId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_profiles" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "displayName" text NOT NULL,
    "email" text NOT NULL,
    "avatarUrl" text,
    "createdAt" timestamp without time zone NOT NULL,
    "lastLoginAt" timestamp without time zone,
    "totalCheckins" bigint NOT NULL,
    "currentStreak" bigint NOT NULL,
    "longestStreak" bigint NOT NULL,
    "averageMood" double precision NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "user_profile_auth_idx" ON "user_profiles" USING btree ("authUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_settings" (
    "id" bigserial PRIMARY KEY,
    "userProfileId" bigint NOT NULL,
    "reminderHour" bigint NOT NULL,
    "reminderMinute" bigint NOT NULL,
    "reminderEnabled" boolean NOT NULL,
    "darkMode" boolean NOT NULL,
    "uiLanguage" text NOT NULL,
    "voiceLanguage" text NOT NULL,
    "privacyLevel" text NOT NULL,
    "notificationsEnabled" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "settings_user_idx" ON "user_settings" USING btree ("userProfileId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "voice_entries" (
    "id" bigserial PRIMARY KEY,
    "userProfileId" bigint NOT NULL,
    "recordedAt" timestamp without time zone NOT NULL,
    "language" text NOT NULL,
    "audioUrl" text,
    "durationSeconds" double precision NOT NULL,
    "pitchMean" double precision NOT NULL,
    "pitchStd" double precision NOT NULL,
    "energyMean" double precision NOT NULL,
    "tempo" double precision NOT NULL,
    "silenceRatio" double precision NOT NULL,
    "transcript" text,
    "emotionKeywords" json NOT NULL,
    "sentimentScore" double precision NOT NULL,
    "detectedEmotions" json NOT NULL,
    "topicContext" text,
    "acousticMoodScore" double precision NOT NULL,
    "semanticMoodScore" double precision NOT NULL,
    "finalMoodScore" double precision NOT NULL,
    "moodLabel" text NOT NULL,
    "confidence" double precision NOT NULL,
    "signalAlignment" double precision NOT NULL,
    "note" text,
    "privacyLevel" text NOT NULL
);

-- Indexes
CREATE INDEX "voice_entry_user_idx" ON "voice_entries" USING btree ("userProfileId");
CREATE INDEX "voice_entry_recorded_idx" ON "voice_entries" USING btree ("recordedAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "wellness_goals" (
    "id" bigserial PRIMARY KEY,
    "userProfileId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "title" text NOT NULL,
    "emoji" text NOT NULL,
    "isCompleted" boolean NOT NULL,
    "completedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "goal_user_idx" ON "wellness_goals" USING btree ("userProfileId");


--
-- MIGRATION VERSION FOR resonate_server
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('resonate_server', '20260126031516573', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260126031516573', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20251208110333922-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110333922-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260109031533194', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260109031533194', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20251208110412389-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110412389-v3-0-0', "timestamp" = now();


COMMIT;
