BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "contacts" (
    "id" bigserial PRIMARY KEY,
    "userProfileId" bigint,
    "name" text NOT NULL,
    "phone" text,
    "email" text,
    "relationship" text,
    "emoji" text,
    "isPrimary" boolean,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "goals" (
    "id" bigserial PRIMARY KEY,
    "userProfileId" bigint,
    "title" text NOT NULL,
    "description" text,
    "category" text,
    "targetDate" timestamp without time zone,
    "isCompleted" boolean,
    "completedAt" timestamp without time zone,
    "createdAt" timestamp without time zone,
    "updatedAt" timestamp without time zone
);

--
-- ACTION ALTER TABLE
--
DROP INDEX "gratitude_user_idx";
ALTER TABLE "gratitude_entries" ALTER COLUMN "userProfileId" DROP NOT NULL;
ALTER TABLE "gratitude_entries" ALTER COLUMN "createdAt" DROP NOT NULL;
--
-- ACTION ALTER TABLE
--
DROP INDEX "journal_user_idx";
ALTER TABLE "journal_entries" ALTER COLUMN "userProfileId" DROP NOT NULL;
ALTER TABLE "journal_entries" ALTER COLUMN "createdAt" DROP NOT NULL;

--
-- MIGRATION VERSION FOR resonate_server
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('resonate_server', '20260128131542137', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260128131542137', "timestamp" = now();

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
