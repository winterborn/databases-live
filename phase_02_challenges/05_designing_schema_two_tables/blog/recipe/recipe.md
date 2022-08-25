# Two Tables Design Recipe Template

_Copy this recipe template to design and create two related database tables from a specification._

## 1. Extract nouns from the user stories or specification

```
As a blogger
So I can write interesting stuff
I want to write posts having a title.

As a blogger
So I can write interesting stuff
I want to write posts having a content.

As a blogger
So I can let people comment on interesting stuff
I want to allow comments on my posts.

As a blogger
So I can let people comment on interesting stuff
I want the comments to have a content.

As a blogger
So I can let people comment on interesting stuff
I want the author to include their name in comments.
```

```
Nouns:

posts, title, content
comments, posts, content, author_name
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record   | Properties                  |
| -------- | --------------------------- |
| posts    | title, content              |
| comments | posts, content, author_name |

1. Name of the first table (always plural): `posts`

   Column names: `title`, `content`

2. Name of the second table (always plural): `comments`

   Column names: `posts`, `content`, `author_name`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: posts
id: SERIAL
title: text
content: text

Table: comments
id: SERIAL
posts: text
content: text
author_name: text
```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one POST have many COMMENTS (YES)
2. Can one COMMENT have many POSTS? (NO)

You'll then be able to say that:

1. **[POST] has many [COMMENTS]**
2. And on the other side, **[COMMENTS] belongs to [POSTS]**
3. In that case, the foreign key is in the table [COMMENTS]

Replace the relevant bits in this example with your own:

_If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table)._

## 4. Write the SQL.

```sql
-- EXAMPLE
-- file: posts_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text
);

-- Then the table with the foreign key.
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  content text,
  author_name text,
-- The foreign key name is always {other_table_singular}_id
  post_id int,
  constraint fk_post foreign key(post_id)
    references posts(id)
    on delete cascade
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 database_name < albums_table.sql
```
