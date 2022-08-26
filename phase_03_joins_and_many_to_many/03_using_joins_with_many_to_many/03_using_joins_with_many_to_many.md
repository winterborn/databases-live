Using a JOIN to select

```sql
-- Select all the tags associated with a given post.
-- Note how we're using two different joins to "link"
-- all the three tables together:
-- _ first, by matching only records in the join table for the given post
-- _ second, by matching only tags for these records in the join table
SELECT tags.id, tags.name
FROM tags
JOIN posts_tags ON posts_tags.tag_id = tags.id
JOIN posts ON posts_tags.post_id = posts.id
WHERE posts.id = 2;
```

When writing a complex JOIN like above, it's often a good idea to diagram the "path" of the different joins, from the initial condition (here, the post ID) to the final result we need (the tags).

It's often helpful to read such a query in "reverse", starting from the end of it:

We filter records in posts by the post ID.
We join the posts table with the posts_tags join table.
We join the posts_tags join table with the tags table.
We get the tags.

Exercise One:
Use a SELECT query with a JOIN to retrieve all the posts associated with the tag 'travel'.

You should get the following result set:

id | title  
----+-------------------------
4 | My weekend in Edinburgh
6 | A foodie week in Spain

```sql
SELECT
	posts.id,
	posts.title
FROM
	posts
	JOIN posts_tags ON posts_tags.post_id = posts.id
	JOIN tags ON posts_tags.tag_id = tags.id
WHERE
	tags.id = 2;
```

Challenge:
Use SQL to insert a new tag 'sql' and associate the post titled 'SQL basics' with this tag.

Then use a SELECT query with a JOIN to retrieve all posts associated with the tag 'sql' and verify the above worked.

```sql
SELECT
	posts.id,
	posts.title
FROM
	posts
	JOIN posts_tags ON posts_tags.post_id = posts.id
	JOIN tags ON posts_tags.tag_id = tags.id
WHERE
	tags.id = 5;
```
