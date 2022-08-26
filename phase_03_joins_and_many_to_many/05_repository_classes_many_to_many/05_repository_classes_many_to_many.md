# Repository classes with many-to-many relationships

_**This is a Makers Bite.** Bites are designed to train specific skills or
tools. They contain an intro, a demonstration video, some exercises with an
example solution video, and a challenge without a solution video for you to test
your learning. [Read more about how to use Makers
Bites.](https://github.com/makersacademy/course/blob/main/labels/bites.md)_

Learn to design Repository classes using many-to-many relationships.

## Intro

```ruby
post_repository = PostRepository.new

posts = post_repository.find_by_tag("coding")

# The array `posts` should contain the following Post objects:
#
#  * 1	How to use Git
#  * 2	Ruby classes
#  * 3	Using IRB
#  * 7  SQL basics
```

| Method        | Job                              | Arguments      | SQL query          | Returns         |
| ------------- | -------------------------------- | -------------- | ------------------ | --------------- |
| `find_by_tag` | Find all posts for the given tag | A tag (string) | `SELECT ... JOIN ` | Array of `Post` |

<!-- OMITTED -->

## Exercise

Setup a new project `blog` for this exercise.

Test-drive and implement Model and Repository classes for the table `posts`, with the method `PostRepository#find_by_tag` having the behaviour described above.

<!-- OMITTED -->

## Challenge

For this challenge, reuse the database schema created [in the previous section](./03_using_joins_with_many_to_many.md) (with the Many-to-Many between `posts` and `tags`).

Test-drive and implement Model and Repository classes for the table `tags`, with the method `TagRepository#find_by_post`. This method should accept a post ID, and return an array of related `Tag` objects.
