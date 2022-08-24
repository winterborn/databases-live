require_relative "lib/database_connection"
require_relative "lib/user_account_repository"

DatabaseConnection.connect("social_network")

user_repository = UserAccountRepository.new

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
# user_repository.delete(4)
# user_repository.all.each { |user| p user }

# p update user account and show all:
# update_user = user_repository.find(1)
# update_user.email_address = 'DarthVader@gmail.com'
# update_user.username = 'MyNewEmpire'
# user_repository.update(update_user)
# user_repository.all.each { |user| p user }