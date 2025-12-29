BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "attendance" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "attendance" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "userId" uuid NOT NULL,
    "inTime" text,
    "outTime" text,
    "inTimeStatus" text,
    "outTimeStatus" text,
    "overTime" text,
    "earlyTime" text,
    "date" timestamp without time zone NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "breaks" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "breaks" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "userId" uuid NOT NULL,
    "breakStart" text,
    "breakEnd" text,
    "breakTime" bigint,
    "date" timestamp without time zone NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "bucket_ticket_map" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "bucket_ticket_map" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "bucketId" uuid NOT NULL,
    "ticketId" uuid NOT NULL,
    "order" bigint NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "buckets" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "buckets" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "userId" uuid NOT NULL,
    "appId" uuid NOT NULL,
    "bucketName" text NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "chat_message" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "chat_message" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "roomId" uuid NOT NULL,
    "parentMessageId" uuid,
    "userId" uuid NOT NULL,
    "message" text NOT NULL,
    "messageType" text NOT NULL,
    "seenUserList" json NOT NULL,
    "sameUser" boolean NOT NULL,
    "deleted" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "chat_room" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "chat_room" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "roomName" text,
    "roomType" text NOT NULL,
    "lastMessageId" uuid,
    "messageCount" bigint NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "doc" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "doc" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "appId" uuid NOT NULL,
    "name" text NOT NULL,
    "doc" text,
    "outline" text,
    "lastUpdated" timestamp without time zone NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "flow" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "flow" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "appId" uuid NOT NULL,
    "name" text NOT NULL,
    "flow" text NOT NULL,
    "lastUpdated" timestamp without time zone NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "leave_config" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "leave_config" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "configName" text NOT NULL,
    "fullDay" bigint NOT NULL,
    "halfDay" bigint NOT NULL,
    "config" text
);

--
-- ACTION DROP TABLE
--
DROP TABLE "leave_request" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "leave_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "userId" uuid NOT NULL,
    "request" text NOT NULL,
    "accepted" boolean,
    "date" timestamp without time zone
);

--
-- ACTION DROP TABLE
--
DROP TABLE "organization" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "organization" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "name" text NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "planner_apps" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "planner_apps" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "appName" text NOT NULL,
    "colorId" uuid NOT NULL,
    "organizationId" uuid
);

--
-- ACTION DROP TABLE
--
DROP TABLE "planner_notifications" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "planner_notifications" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "notification" text NOT NULL,
    "notificationType" text NOT NULL,
    "ticketId" uuid NOT NULL,
    "userId" uuid NOT NULL,
    "seenUserList" json NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "priority" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "priority" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "priorityName" text NOT NULL,
    "priority" bigint NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "status" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "status" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "statusName" text NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "system_color" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "system_color" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "colorName" text,
    "color" text NOT NULL,
    "isDefault" boolean NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "ticket_assignee" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ticket_assignee" (
    "id" bigserial PRIMARY KEY,
    "ticketId" uuid NOT NULL,
    "userId" uuid NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "ticket_attachments" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ticket_attachments" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "ticketId" uuid NOT NULL,
    "attachmentName" text NOT NULL,
    "attachmentSize" double precision NOT NULL,
    "attachmentUrl" text NOT NULL,
    "attachmentType" text NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "ticket_comments" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ticket_comments" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "ticketId" uuid NOT NULL,
    "userId" uuid NOT NULL,
    "message" text NOT NULL,
    "createdAt" timestamp without time zone
);

--
-- ACTION DROP TABLE
--
DROP TABLE "ticket_status_change" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ticket_status_change" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "ticketId" uuid NOT NULL,
    "userId" uuid NOT NULL,
    "oldStatusId" uuid NOT NULL,
    "newStatusId" uuid NOT NULL,
    "changedAt" timestamp without time zone
);

--
-- ACTION DROP TABLE
--
DROP TABLE "ticket_type" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ticket_type" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "typeName" text NOT NULL,
    "colorId" uuid NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "tickets" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "tickets" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "userId" uuid NOT NULL,
    "appId" uuid NOT NULL,
    "ticketName" text NOT NULL,
    "ticketBody" text NOT NULL,
    "statusId" uuid NOT NULL,
    "priorityId" uuid NOT NULL,
    "typeId" uuid NOT NULL,
    "checklist" json,
    "flows" text NOT NULL,
    "creds" bigint NOT NULL,
    "deadline" timestamp without time zone
);

--
-- ACTION DROP TABLE
--
DROP TABLE "user_devices" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_devices" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "userId" uuid NOT NULL,
    "deviceType" text NOT NULL,
    "hardwareId" text NOT NULL,
    "socketId" text
);

--
-- ACTION DROP TABLE
--
DROP TABLE "user_room_map" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_room_map" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "roomId" uuid NOT NULL,
    "userId" uuid NOT NULL,
    "lastSeenMessageId" uuid
);

--
-- ACTION DROP TABLE
--
DROP TABLE "user_types" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_types" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "userType" text NOT NULL,
    "colorId" uuid NOT NULL,
    "permissions" text NOT NULL,
    "isAdmin" boolean NOT NULL
);

--
-- ACTION DROP TABLE
--
DROP TABLE "users" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "users" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    "userName" text NOT NULL,
    "password" text,
    "image" text,
    "organizationId" uuid NOT NULL,
    "colorId" uuid NOT NULL,
    "userTypeId" uuid NOT NULL,
    "leaveConfigId" uuid NOT NULL,
    "performanceConfigId" bigint,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL,
    "gender" text NOT NULL,
    "dateOfBirth" timestamp without time zone,
    "phone" text NOT NULL,
    "email" text NOT NULL,
    "bloodGroup" text,
    "salary" text,
    "experience" text,
    "punchId" text,
    "attachments" text,
    "performance" bigint NOT NULL,
    "plannerVariables" text,
    "online" boolean NOT NULL,
    "onsite" boolean NOT NULL,
    "deleted" boolean NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "attendance"
    ADD CONSTRAINT "attendance_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "breaks"
    ADD CONSTRAINT "breaks_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "bucket_ticket_map"
    ADD CONSTRAINT "bucket_ticket_map_fk_0"
    FOREIGN KEY("bucketId")
    REFERENCES "buckets"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "bucket_ticket_map"
    ADD CONSTRAINT "bucket_ticket_map_fk_1"
    FOREIGN KEY("ticketId")
    REFERENCES "tickets"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "buckets"
    ADD CONSTRAINT "buckets_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "leave_request"
    ADD CONSTRAINT "leave_request_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "planner_notifications"
    ADD CONSTRAINT "planner_notifications_fk_0"
    FOREIGN KEY("ticketId")
    REFERENCES "tickets"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "planner_notifications"
    ADD CONSTRAINT "planner_notifications_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "ticket_assignee"
    ADD CONSTRAINT "ticket_assignee_fk_0"
    FOREIGN KEY("ticketId")
    REFERENCES "tickets"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "ticket_assignee"
    ADD CONSTRAINT "ticket_assignee_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "ticket_attachments"
    ADD CONSTRAINT "ticket_attachments_fk_0"
    FOREIGN KEY("ticketId")
    REFERENCES "tickets"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "ticket_comments"
    ADD CONSTRAINT "ticket_comments_fk_0"
    FOREIGN KEY("ticketId")
    REFERENCES "tickets"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "ticket_comments"
    ADD CONSTRAINT "ticket_comments_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "ticket_status_change"
    ADD CONSTRAINT "ticket_status_change_fk_0"
    FOREIGN KEY("ticketId")
    REFERENCES "tickets"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "ticket_status_change"
    ADD CONSTRAINT "ticket_status_change_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "ticket_status_change"
    ADD CONSTRAINT "ticket_status_change_fk_2"
    FOREIGN KEY("oldStatusId")
    REFERENCES "status"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "ticket_status_change"
    ADD CONSTRAINT "ticket_status_change_fk_3"
    FOREIGN KEY("newStatusId")
    REFERENCES "status"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "ticket_type"
    ADD CONSTRAINT "ticket_type_fk_0"
    FOREIGN KEY("colorId")
    REFERENCES "system_color"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "tickets"
    ADD CONSTRAINT "tickets_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "tickets"
    ADD CONSTRAINT "tickets_fk_1"
    FOREIGN KEY("statusId")
    REFERENCES "status"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "tickets"
    ADD CONSTRAINT "tickets_fk_2"
    FOREIGN KEY("priorityId")
    REFERENCES "priority"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "tickets"
    ADD CONSTRAINT "tickets_fk_3"
    FOREIGN KEY("typeId")
    REFERENCES "ticket_type"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_devices"
    ADD CONSTRAINT "user_devices_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "users"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_types"
    ADD CONSTRAINT "user_types_fk_0"
    FOREIGN KEY("colorId")
    REFERENCES "system_color"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "users"
    ADD CONSTRAINT "users_fk_0"
    FOREIGN KEY("organizationId")
    REFERENCES "organization"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "users"
    ADD CONSTRAINT "users_fk_1"
    FOREIGN KEY("colorId")
    REFERENCES "system_color"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "users"
    ADD CONSTRAINT "users_fk_2"
    FOREIGN KEY("userTypeId")
    REFERENCES "user_types"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "users"
    ADD CONSTRAINT "users_fk_3"
    FOREIGN KEY("leaveConfigId")
    REFERENCES "leave_config"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR crewboard
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('crewboard', '20251225141144353', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20251225141144353', "timestamp" = now();

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
