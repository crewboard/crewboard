BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "buckets" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "buckets" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "appId" bigint NOT NULL,
    "bucketName" text NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "tickets" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "tickets" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "appId" bigint NOT NULL,
    "ticketName" text NOT NULL,
    "ticketBody" text NOT NULL,
    "statusId" bigint NOT NULL,
    "priorityId" bigint NOT NULL,
    "typeId" bigint NOT NULL,
    "checklist" text NOT NULL,
    "flows" text NOT NULL,
    "creds" bigint NOT NULL,
    "deadline" timestamp without time zone
);


--
-- MIGRATION VERSION FOR crewboard
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('crewboard', '20251224044643828', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251224044643828', "timestamp" = now();

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
    VALUES ('serverpod_auth_idp', '20251208110420531-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110420531-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20250825102351908-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250825102351908-v3-0-0', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20251208110412389-v3-0-0', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251208110412389-v3-0-0', "timestamp" = now();


COMMIT;
