-- Write your SQL seed here.

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE posts RESTART IDENTITY CASCADE;
TRUNCATE TABLE comments RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content) VALUES ('Blog Post 1', 'Blog Post Content 1');
INSERT INTO posts (title, content) VALUES ('Blog Post 2', 'Blog Post Content 2');
INSERT INTO posts (title, content) VALUES ('Blog Post 3', 'Blog Post Content 3');
INSERT INTO comments (content, author_name, post_id) VALUES ('I love this!', 'Phil', 1);
INSERT INTO comments (content, author_name, post_id) VALUES ('I hate this!', 'Kat', 1);
INSERT INTO comments (content, author_name, post_id) VALUES ('Very interesting...', 'Louisa', 2);
INSERT INTO comments (content, author_name, post_id) VALUES ('Boring!!!', 'Will', 3);
