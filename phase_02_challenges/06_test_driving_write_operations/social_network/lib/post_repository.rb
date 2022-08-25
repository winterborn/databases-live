require_relative "./post"

class PostRepository
    def all
        sql = "SELECT id, title, content, number_of_views, user_account_id FROM posts;"
        result_set = DatabaseConnection.exec_params(sql, [])

        post_list = []
        result_set.each do |record|
            post = Post.new
            post.id = record["id"].to_i
            post.title = record["title"]
            post.content = record["content"]
            post.number_of_views = record["number_of_views"].to_i
            post.user_account_id = record["user_account_id"].to_i
            
            post_list << post
        end

        # puts "#{post_list[0].title}: #{post_list[0].content}"
        return post_list
    end

    def find(id)
        sql = "SELECT id, title, content, number_of_views, user_account_id FROM posts WHERE id = $1;"
        sql_params = [id]
        result_set = DatabaseConnection.exec_params(sql, sql_params)

        record = result_set[0]
        # ask coaches about this ^

        post = Post.new
        post.id = record["id"].to_i
        post.title = record["title"]
        post.content = record["content"]
        post.number_of_views = record["number_of_views"].to_i
        post.user_account_id = record["user_account_id"].to_i

        return post
    end

    def create(post)
        sql = 'INSERT INTO posts (title, content, number_of_views, user_account_id) VALUES ($1, $2, $3, $4);'
        sql_params = [post.title, post.content, post.number_of_views, post.user_account_id]
        DatabaseConnection.exec_params(sql, sql_params)

        return nil
    end

    def delete(id)
        sql = 'DELETE FROM posts WHERE id = $1;'
        sql_params = [id]
        DatabaseConnection.exec_params(sql, sql_params)

        return nil
    end

    def update(post)
        sql = 'UPDATE posts SET title = $1, content = $2, number_of_views = $3, user_account_id = $4 WHERE id = $5;'
        sql_params = [post.title, post.content, post.number_of_views, post.user_account_id, post.id]
        DatabaseConnection.exec_params(sql, sql_params)

        return nil
     end
end