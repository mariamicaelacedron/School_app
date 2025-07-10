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
CREATE TABLE IF NOT EXISTS "users" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar DEFAULT '' NOT NULL, "encrypted_password" varchar DEFAULT '' NOT NULL, "reset_password_token" varchar, "reset_password_sent_at" datetime, "remember_created_at" datetime, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "role" integer DEFAULT 0, "name" varchar /*application='SchoolApp'*/);
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email") /*application='SchoolApp'*/;
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token") /*application='SchoolApp'*/;
INSERT INTO "schema_migrations" (version) VALUES
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

