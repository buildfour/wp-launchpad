BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "access_session" ADD COLUMN "userId" bigint;
ALTER TABLE "access_session" ADD COLUMN "userEmail" text;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "activity_logs" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint,
    "userEmail" text,
    "action" text NOT NULL,
    "details" text,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "project_state" ADD COLUMN "userId" bigint;
ALTER TABLE "project_state" ADD COLUMN "userEmail" text;
ALTER TABLE "project_state" ADD COLUMN "databaseHost" text;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "users" (
    "id" bigserial PRIMARY KEY,
    "email" text NOT NULL,
    "name" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);


--
-- MIGRATION VERSION FOR wp_launchpad
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wp_launchpad', '20260125133921568', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260125133921568', "timestamp" = now();

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
