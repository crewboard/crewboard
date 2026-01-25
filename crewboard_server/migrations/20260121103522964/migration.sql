BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "system_variables" ADD COLUMN "fontSizeBody" double precision;
ALTER TABLE "system_variables" ADD COLUMN "fontSizeTitle" double precision;
ALTER TABLE "system_variables" ADD COLUMN "fontSizeHeading1" double precision;
ALTER TABLE "system_variables" ADD COLUMN "fontSizeHeading2" double precision;
ALTER TABLE "system_variables" ADD COLUMN "fontSizeHeading3" double precision;
ALTER TABLE "system_variables" ADD COLUMN "fontFamily" text;

--
-- MIGRATION VERSION FOR crewboard
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('crewboard', '20260121103522964', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260121103522964', "timestamp" = now();

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
