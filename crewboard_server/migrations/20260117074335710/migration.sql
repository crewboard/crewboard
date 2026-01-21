BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "emoji" (
    "id" bigserial PRIMARY KEY,
    "emoji" text NOT NULL,
    "hexcode" text NOT NULL,
    "group" text NOT NULL,
    "subgroup" text NOT NULL,
    "annotation" text NOT NULL,
    "tags" json NOT NULL,
    "shortcodes" json NOT NULL,
    "emoticons" json NOT NULL
);


--
-- MIGRATION VERSION FOR crewboard
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('crewboard', '20260117074335710', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260117074335710', "timestamp" = now();

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
