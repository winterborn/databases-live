-- -------------------------------------------------------------
-- TablePlus 4.8.2(436)
--
-- https://tableplus.com/
--
-- Database: social_network
-- Generation Time: 2022-08-24 17:34:24.8820
-- -------------------------------------------------------------


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

INSERT INTO "public"."posts" ("id", "title", "content", "number_of_views", "user_account_id") VALUES
(1, 'Makers', 'Started bootcamp today.', 12, 1),
(2, 'New recipe', 'Try this new pasta dish.', 48, 2),
(3, 'Hobbies to try:', 'Rock climbing, making films, walks in nature...', 89, 2),
(4, 'Favourite Films:', 'Star Wars, Indiana Jones, Ready Player One, Blade Runner', 100, 3);

INSERT INTO "public"."user_accounts" ("id", "email_address", "username") VALUES
(1, 'myfirstemail@email.com', 'skywalker'),
(2, 'newpersonhere@email.com', '80sGamer'),
(3, 'email@email.com', 'Generic123');

ALTER TABLE "public"."posts" ADD FOREIGN KEY ("user_account_id") REFERENCES "public"."user_accounts"("id") ON DELETE CASCADE;
