BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "buckets" DROP CONSTRAINT "buckets_fk_0";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "ticket_type" DROP CONSTRAINT "ticket_type_fk_0";
--
-- ACTION ALTER TABLE
--
ALTER TABLE "tickets" DROP CONSTRAINT "tickets_fk_0";
ALTER TABLE "tickets" DROP CONSTRAINT "tickets_fk_1";
ALTER TABLE "tickets" DROP CONSTRAINT "tickets_fk_2";
ALTER TABLE "tickets" DROP CONSTRAINT "tickets_fk_3";

--
-- MIGRATION VERSION FOR crewboard
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('crewboard', '20251223125143154', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251223125143154', "timestamp" = now();

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
