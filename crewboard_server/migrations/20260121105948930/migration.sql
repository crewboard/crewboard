BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "font_setting" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "fontSize" double precision,
    "fontFamily" text,
    "fontWeight" text,
    "color" text
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "system_variables" DROP COLUMN "fontSizeBody";
ALTER TABLE "system_variables" DROP COLUMN "fontSizeTitle";
ALTER TABLE "system_variables" DROP COLUMN "fontSizeHeading1";
ALTER TABLE "system_variables" DROP COLUMN "fontSizeHeading2";
ALTER TABLE "system_variables" DROP COLUMN "fontSizeHeading3";
ALTER TABLE "system_variables" DROP COLUMN "fontFamily";

--
-- MIGRATION VERSION FOR crewboard
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('crewboard', '20260121105948930', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260121105948930', "timestamp" = now();

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
