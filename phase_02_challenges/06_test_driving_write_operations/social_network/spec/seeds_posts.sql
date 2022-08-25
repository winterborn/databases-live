-- Write your SQL seed here.

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE user_accounts RESTART IDENTITY CASCADE;
TRUNCATE TABLE posts RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO user_accounts (email_address, username) VALUES ('AnakinSkywalker@gmail.com', 'TheChosenOne');
INSERT INTO user_accounts (email_address, username) VALUES ('HyruleHelper@gmail.com', 'ElfBoyLink');
INSERT INTO posts (title, content, number_of_views, user_account_id) VALUES ('First Day', 'Welcome to...', '12', '1');
INSERT INTO posts (title, content, number_of_views, user_account_id) VALUES ('Try this recipe', 'You will need', '43', '1');
INSERT INTO posts (title, content, number_of_views, user_account_id) VALUES ('Enemies Everywhere!', 'Grab your sword and shield...', '99', '2');