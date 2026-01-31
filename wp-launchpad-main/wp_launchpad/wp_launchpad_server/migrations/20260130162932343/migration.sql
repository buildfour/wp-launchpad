BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "activity_logs" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "activity_log" (
    "id" bigserial PRIMARY KEY,
    "visitorId" text NOT NULL,
    "action" text NOT NULL,
    "details" text,
    "projectId" bigint,
    "projectName" text,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "project_state" ADD COLUMN "visitorId" text;

--
-- MIGRATION VERSION FOR wp_launchpad
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('wp_launchpad', '20260130162932343', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260130162932343', "timestamp" = now();

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
