Here is the general syntax:

```sql
SELECT [columns to select]
  FROM [table name]
  JOIN [other table name]
  ON [join condition]
```

Example:

```sql
SELECT albums.id, albums.title, artists.id, artists.name
  FROM albums
    JOIN artists
    ON artists.id = albums.artist_id;
```

Exercise One:

Use a JOIN query to select the id and title of all the albums from Taylor Swift.

id | title  
----+----------
6 | Lover
7 | Folklore

```sql
SELECT
	albums.id,
	albums.title,
	albums.release_year
FROM
	albums
	JOIN artists ON albums.artist_id = artists.id
WHERE
	artists.name = 'Taylor Swift';
```

Exercise Two:

Use a JOIN query to find the id and title of the (only) album from Pixies released in 1988.

id | title  
----+-------------
2 | Surfer Rosa

```sql
SELECT
	albums.id,
	albums.title,
	albums.release_year
FROM
	albums
	JOIN artists ON albums.artist_id = artists.id
WHERE
	artists.name = 'Pixies' AND albums.release_year = 1988;
```

Challenge:

Find the id and title of all albums from Nina Simone released after 1975.

album_id | title  
----------+--------------------
9 | Baltimore
11 | Fodder on My Wings

```sql
SELECT
	albums.id,
	albums.title,
	albums.release_year
FROM
	albums
	JOIN artists ON albums.artist_id = artists.id
WHERE
	artists.name = 'Nina Simone' AND albums.release_year > 1975;
```
