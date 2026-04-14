BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "status" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "status" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "statusName" text NOT NULL,
    "working" boolean NOT NULL,
    "completed" boolean NOT NULL
);


--
-- MIGRATION VERSION FOR crewboard
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('crewboard', '20260410081900079', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260410081900079', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20260129181059877', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181059877', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
