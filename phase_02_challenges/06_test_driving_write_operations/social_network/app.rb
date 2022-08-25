require_relative "lib/database_connection"
require_relative "lib/user_account_repository"
require_relative "lib/post_repository"

DatabaseConnection.connect("social_network")

user_repository = UserAccountRepository.new
post_repository = PostRepository.new

# Testing 'real-world' functionality of Posts:
# All posts:
# post_repository.all.each { |post| p post }

# Find specific post - id '4':
# post4 = post_repository.find(4)
# p "#{post4.title}: #{post4.content} - #{post4.number_of_views} views."

# Create post and show all:
# new_post = Post.new
# new_post.title = 'Amazing New Post'
# new_post.content = 'Check out this incredible...'
# new_post.number_of_views = 1028
# new_post.user_account_id = 2
# post_repository.create(new_post)
# post_repository.all.each { |post| p post }

# Delete post and show all:
# post_repository.delete(8)
# post_repository.all.each { |post| p post }

# Update post and show all:
# update_post = post_repository.find(1)
# update_post.title = 'Final Boss Fight'
# update_post.content = 'We have come so far...'
# update_post.number_of_views = 9000
# update_post.user_account_id = 2
# post_repository.update(update_post)
# post_repository.all.each { |post| p post }


# Testing 'real-world' functionality of User Accounts:
# p all user accounts:
# user_repository.all.each { |user| p user }

# p specific user account - id '3':
# user3 = user_repository.find(3)
# p "#{user3.email_address} - #{user3.username}"

# p create new user account and show all:
# new_user = UserAccount.new
# new_user.email_address = 'HardTimes@Yahoo.co.uk'
# new_user.username = 'MyBrainIsMush'
# user_repository.create(new_user)
# user_repository.all.each { |user| p user }

# p delete user account and show all:
# user_repository.delete(5)
# user_repository.all.each { |user| p user }

# p update user account and show all:
# update_user = user_repository.find(1)
# update_user.email_address = 'DarthVader@gmail.com'
# update_user.username = 'MyNewEmpire'
# user_repository.update(update_user)
# user_repository.all.each { |user| p user }