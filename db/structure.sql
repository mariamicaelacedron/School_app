CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE IF NOT EXISTS "courses" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "description" text, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "admins" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_378b9734e4"
FOREIGN KEY ("user_id")
  REFERENCES "users" ("id")
);
CREATE INDEX "index_admins_on_user_id" ON "admins" ("user_id") /*application='SchoolApp'*/;
CREATE TABLE IF NOT EXISTS "students" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "course_id" integer NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_148c9e88f4"
FOREIGN KEY ("user_id")
  REFERENCES "users" ("id")
, CONSTRAINT "fk_rails_a258d82422"
FOREIGN KEY ("course_id")
  REFERENCES "courses" ("id")
);
CREATE INDEX "index_students_on_user_id" ON "students" ("user_id") /*application='SchoolApp'*/;
CREATE INDEX "index_students_on_course_id" ON "students" ("course_id") /*application='SchoolApp'*/;
CREATE TABLE IF NOT EXISTS "grades" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "admin_id" integer NOT NULL, "student_name" varchar, "subject" varchar, "score" float, "comment" text, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "semester" integer DEFAULT 1 /*application='SchoolApp'*/, CONSTRAINT "fk_rails_22730debfa"
FOREIGN KEY ("user_id")
  REFERENCES "users" ("id")
, CONSTRAINT "fk_rails_bef37a4248"
FOREIGN KEY ("admin_id")
  REFERENCES "users" ("id")
);
CREATE INDEX "index_grades_on_user_id" ON "grades" ("user_id") /*application='SchoolApp'*/;
CREATE INDEX "index_grades_on_admin_id" ON "grades" ("admin_id") /*application='SchoolApp'*/;
CREATE TABLE IF NOT EXISTS "users" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar DEFAULT '' NOT NULL, "encrypted_password" varchar DEFAULT '' NOT NULL, "reset_password_token" varchar, "reset_password_sent_at" datetime, "remember_created_at" datetime, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "role" integer DEFAULT 0, "name" varchar /*application='SchoolApp'*/, "description" text /*application='SchoolApp'*/, "avatar" varchar /*application='SchoolApp'*/);
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email") /*application='SchoolApp'*/;
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token") /*application='SchoolApp'*/;
CREATE TABLE IF NOT EXISTS "summaries" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer NOT NULL, "week_start" date, "activities" text, "participated" boolean, "remarks" text, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "student_name" varchar /*application='SchoolApp'*/, CONSTRAINT "fk_rails_df9cba4ece"
FOREIGN KEY ("user_id")
  REFERENCES "users" ("id")
);
CREATE INDEX "index_summaries_on_user_id" ON "summaries" ("user_id") /*application='SchoolApp'*/;
CREATE TABLE IF NOT EXISTS "active_storage_blobs" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "key" varchar NOT NULL, "filename" varchar NOT NULL, "content_type" varchar, "metadata" text, "service_name" varchar NOT NULL, "byte_size" bigint NOT NULL, "checksum" varchar, "created_at" datetime(6) NOT NULL);
CREATE UNIQUE INDEX "index_active_storage_blobs_on_key" ON "active_storage_blobs" ("key") /*application='SchoolApp'*/;
CREATE TABLE IF NOT EXISTS "active_storage_attachments" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar NOT NULL, "record_type" varchar NOT NULL, "record_id" bigint NOT NULL, "blob_id" bigint NOT NULL, "created_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_c3b3935057"
FOREIGN KEY ("blob_id")
  REFERENCES "active_storage_blobs" ("id")
);
CREATE INDEX "index_active_storage_attachments_on_blob_id" ON "active_storage_attachments" ("blob_id") /*application='SchoolApp'*/;
CREATE UNIQUE INDEX "index_active_storage_attachments_uniqueness" ON "active_storage_attachments" ("record_type", "record_id", "name", "blob_id") /*application='SchoolApp'*/;
CREATE TABLE IF NOT EXISTS "active_storage_variant_records" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "blob_id" bigint NOT NULL, "variation_digest" varchar NOT NULL, CONSTRAINT "fk_rails_993965df05"
FOREIGN KEY ("blob_id")
  REFERENCES "active_storage_blobs" ("id")
);
CREATE UNIQUE INDEX "index_active_storage_variant_records_uniqueness" ON "active_storage_variant_records" ("blob_id", "variation_digest") /*application='SchoolApp'*/;
CREATE TABLE IF NOT EXISTS "sessions" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "description" text, "start_time" datetime(6), "end_time" datetime(6), "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "session_students" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "session_id" integer NOT NULL, "student_id" integer NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "attended" boolean DEFAULT 0 /*application='SchoolApp'*/, CONSTRAINT "fk_rails_02959b8614"
FOREIGN KEY ("student_id")
  REFERENCES "users" ("id")
, CONSTRAINT "fk_rails_aee5d47d8b"
FOREIGN KEY ("session_id")
  REFERENCES "sessions" ("id")
);
CREATE INDEX "index_session_students_on_session_id" ON "session_students" ("session_id") /*application='SchoolApp'*/;
CREATE INDEX "index_session_students_on_student_id" ON "session_students" ("student_id") /*application='SchoolApp'*/;
CREATE TABLE IF NOT EXISTS "course_users" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "course_id" integer NOT NULL, "user_id" integer NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_e18783c035"
FOREIGN KEY ("course_id")
  REFERENCES "courses" ("id")
, CONSTRAINT "fk_rails_e90b3a1577"
FOREIGN KEY ("user_id")
  REFERENCES "users" ("id")
);
CREATE INDEX "index_course_users_on_course_id" ON "course_users" ("course_id") /*application='SchoolApp'*/;
CREATE INDEX "index_course_users_on_user_id" ON "course_users" ("user_id") /*application='SchoolApp'*/;
CREATE TABLE IF NOT EXISTS "attendances" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "course_id" integer NOT NULL, "user_id" integer NOT NULL, "date" date, "status" varchar DEFAULT 'present', "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_77ad02f5c5"
FOREIGN KEY ("user_id")
  REFERENCES "users" ("id")
, CONSTRAINT "fk_rails_2fe8e02b1e"
FOREIGN KEY ("course_id")
  REFERENCES "courses" ("id")
);
CREATE INDEX "index_attendances_on_course_id" ON "attendances" ("course_id") /*application='SchoolApp'*/;
CREATE INDEX "index_attendances_on_user_id" ON "attendances" ("user_id") /*application='SchoolApp'*/;
INSERT INTO "schema_migrations" (version) VALUES
('20250711214419'),
('20250711203739'),
('20250711203738'),
('20250711191752'),
('20250711190101'),
('20250711190053'),
('20250711165756'),
('20250711165519'),
('20250711161650'),
('20250710204739'),
('20250710181438'),
('20250710150324'),
('20250709185806'),
('20250709184310'),
('20250709174717'),
('20250708015218'),
('20250708010908'),
('20250708004113'),
('20250708004112'),
('20250708004111'),
('20250708004110');

