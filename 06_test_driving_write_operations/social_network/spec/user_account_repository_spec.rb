require "user_account_repository"

RSpec.describe UserAccountRepository do
    def reset_user_accounts_table
        seed_sql = File.read('spec/seeds_user_accounts.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
        connection.exec(seed_sql)
      end
      
      describe UserAccountRepository do
        before(:each) do
          reset_user_accounts_table
        end
    end

    context "#all" do
        it "gets all user accounts" do
            repo = UserAccountRepository.new
            users = repo.all

            users.length # =>  2

            expect(users[0].id).to eq 1
            expect(users[0].email_address).to eq 'AnakinSkywalker@gmail.com'
            expect(users[0].username).to eq 'TheChosenOne'
        end
    end

    context "#find" do
        it "finds a specific user based on given id" do
            repo = UserAccountRepository.new
            users = repo.find(1)

            users.id # =>  1
            users.email_address # =>  'AnakinSkywalker@gmail.com'
            users.username # =>  'TheChosenOne'

            users = repo.find(2)

            users.id # =>  2
            users.email_address # =>  'HyruleHelper@gmail.com'
            users.username # =>  'ElfBoyLink'
        end
    end

    context "#create" do
        it "creates a new user then checks new user is present in all" do
            # Creation of new user account:
            repo = UserAccountRepository.new
            user = UserAccount.new

            user.email_address = 'EyesUpGuardian@hotmail.com'
            user.username = 'Destiny2Destroyer'

            repo.create(user) # => nil

            # Checking of new user account:
            users = repo.all

            last_user = users.last
            expect(last_user.email_address).to eq 'EyesUpGuardian@hotmail.com'
            expect(last_user.username).to eq 'Destiny2Destroyer'
        end
    end

    context "#delete" do
        xit "deletes a single user account with a given id" do
            repo = UserAccountRepository.new
            repo.delete(1)

            all_users = repo.all
            expect(all_users.length).to eq 1
            # will ask coaches
        end

        xit "deletes all users" do
            repo = UserAccountRepository.new
            repo.delete(1)
            repo.delete(2)

            all_users = repo.all
            expect(all_users.length).to eq 0
            # will ask coaches
        end
    end 

    context "#update" do
        it "updates a single user account with given id" do
            # Finds user with ID '1', Creates new user account
            repo = UserAccountRepository.new
            user = repo.find(1)

            user.email_address = 'DarthVader@gmail.com'
            user.username = 'MyNewEmpire'

            # Updates user account info to updated_user
            repo.update(user)
            updated_user = repo.find(1)

            expect(updated_user.email_address).to eq "DarthVader@gmail.com"
            expect(updated_user.username).to eq "MyNewEmpire"
        end
    end
end