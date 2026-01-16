BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "planner_thread_read_status" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "planner_notifications" CASCADE;

--
-- ACTION DROP TABLE
--
DROP TABLE "planner_activities" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ticket_views" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "ticketId" uuid NOT NULL,
    "userId" uuid NOT NULL,
    "lastRead" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "ticket_views"
    ADD CONSTRAINT "ticket_views_fk_0"
    FOREIGN KEY("ticketId")
    REFERENCES "tickets"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "ticket_views"
    ADD CONSTRAINT "ticket_views_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR crewboard
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('crewboard', '20260114113545581', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260114113545581', "timestamp" = now();

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
