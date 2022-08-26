require_relative "./post"
require_relative "./comment"

class PostRepository
  def all
    sql = "SELECT id, title, content FROM posts ORDER BY id;"
    result_set = DatabaseConnection.exec_params(sql, [])

    posts = []

    result_set.each do |record|
      post = Post.new
      post.id = record["id"].to_i
      post.title = record["title"]
      post.content = record["content"]

      posts << post
    end

    return posts
  end

  def find(id)
    sql = "SELECT id, title, content FROM posts WHERE id = $1;"
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]

    post = Post.new
    post.id = record["id"]
    post.title = record["title"]
    post.content = record["content"]

    return post
  end

  def find_with_comments(post_id)
    sql =
      'SELECT
      posts.id AS "id",
      posts.title AS "title",
      posts.content AS "content",
      comments.id AS "comment_id",
      comments.content AS "comment_content",
      comments.author_name AS "comment_author_name"
    FROM
      posts
      JOIN comments ON comments.post_id = posts.id
    WHERE
      posts.id = $1;'
    sql_params = [post_id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    first_record = result_set[0]

    post = record_to_post_object(first_record)

    result_set.each do |record|
      post.comments << record_to_comment_object(record)
    end

    return post
  end

  private

  def record_to_post_object(first_record)
    post = Post.new
    post.id = first_record["id"]
    post.title = first_record["title"]
    post.content = first_record["content"]
    post.comments = []

    return post
  end

  def record_to_comment_object(record)
    comment = Comment.new
    comment.id = record["comment_id"]
    comment.content = record["comment_content"]
    comment.author_name = record["comment_author_name"]

    return comment
  end
end
