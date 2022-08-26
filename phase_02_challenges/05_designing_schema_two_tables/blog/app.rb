require_relative "lib/database_connection"
require_relative "lib/post_repository"

# Test outputs
DatabaseConnection.connect("blog")

# Print all post names:
post_repo = PostRepository.new
# post_repo.all.each { |post| p post.name }

# Print all comment author names associated with post(1)
post = post_repo.find_with_comments(1)
puts "#{post.title}:\n #{post.content}\n * #{post.comments.first.author_name} wrote: #{post.comments.first.content},\n * #{post.comments.last.author_name} wrote: #{post.comments.last.content}"
