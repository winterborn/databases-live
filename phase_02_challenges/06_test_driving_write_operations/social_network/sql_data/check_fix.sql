-- -------------------------------------------------------------
-- TablePlus 4.8.2(436)
--
-- https://tableplus.com/
--
-- Database: social_network_test
-- Generation Time: 2022-08-24 18:34:38.0170
-- -------------------------------------------------------------


DROP TABLE IF EXISTS "public"."posts";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS posts_id_seq;

-- Table Definition
CREATE TABLE "public"."posts" (
    "id" int4 NOT NULL DEFAULT nextval('posts_id_seq'::regclass),
    "title" text,
    "content" text,
    "number_of_views" int4,
    "user_account_id" int4,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."user_accounts";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS user_accounts_id_seq;

-- Table Definition
CREATE TABLE "public"."user_accounts" (
    "id" int4 NOT NULL DEFAULT nextval('user_accounts_id_seq'::regclass),
    "email_address" text,
    "username" text,
    PRIMARY KEY ("id")
);

INSERT INTO "public"."user_accounts" ("id", "email_address", "username") VALUES
(1, 'AnakinSkywalker@gmail.com', 'TheChosenOne'),
(2, 'HyruleHelper@gmail.com', 'ElfBoyLink');

ALTER TABLE "public"."posts" ADD FOREIGN KEY ("user_account_id") REFERENCES "public"."user_accounts"("id") ON DELETE CASCADE;
