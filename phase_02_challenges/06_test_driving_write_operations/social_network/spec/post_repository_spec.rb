require "post_repository"

RSpec.describe PostRepository do
    def reset_posts_table
        seed_sql = File.read('spec/seeds_posts.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
        connection.exec(seed_sql)
    end
      
    describe PostRepository do
        before(:each) do
          reset_posts_table
        end
      
        context "#all" do
            it "gets all posts" do
                repo = PostRepository.new
                posts = repo.all

                posts.length # =>  3

                posts[0].id # =>  1
                posts[0].title # =>  'First Day'
                posts[0].content # =>  'Welcome to...'
                posts[0].number_of_views # =>  '12'
                posts[0].user_account_id # =>  '1'
            end
        end

        context "#find" do
            it "gets a single post given a specific id" do
                repo = PostRepository.new
                post = repo.find(1)

                post.id # =>  1
                post.title # =>  'First Day'
                post.content # =>  'Welcome to...'
                post.number_of_views # =>  '12'
                post.user_account_id # =>  '1'

                post = repo.find(2)

                post.id # =>  2
                post.title # =>  'Try this recipe'
                post.content # =>  'You will need'
                post.number_of_views # =>  '43'
                post.user_account_id # =>  '1'

                post = repo.find(3)

                post.id # =>  3
                post.title # =>  'Enemies Everywhere!'
                post.content # =>  'Grab your sword and shield...'
                post.number_of_views # =>  '99'
                post.user_account_id # =>  '2'
            end
        end

        context "#create" do
            it "creates a new post" do
                # Create a new post
                # Creation of new post:
                repo = PostRepository.new
                post = Post.new

                post.title = 'Amazing New Post'
                post.content = 'Check out this incredible...'
                post.number_of_views = 1028
                post.user_account_id = 2

                repo.create(post) # => nil

                # Checking of new post:
                posts = repo.all

                last_post = posts.last
                expect(last_post.title).to eq 'Amazing New Post'
                expect(last_post.content).to eq 'Check out this incredible...'
                expect(last_post.number_of_views).to eq  1028
                expect(last_post.user_account_id).to eq  2
            end
        end

        context "#delete" do
            it "deletes a single post given a specific id" do
                repo = PostRepository.new
                id_to_delete = 1

                repo.delete(id_to_delete)

                all_posts = repo.all
                expect(all_posts.length).to eq 2 # => 2 because of 3 test posts
                expect(all_posts.first.id).to eq 2
            end
        end

        context "#update" do
            it "updates a post given a specific id" do
                repo = PostRepository.new
                post = repo.find(3)

                post.title = 'Final Boss Fight'
                post.content = 'We have come so far...'
                post.number_of_views = 9000
                post.user_account_id = 2

                repo.update(post)

                updated_post = repo.find(3)
                expect(updated_post.title).to eq 'Final Boss Fight'
                expect(updated_post.content).to eq 'We have come so far...'
                expect(updated_post.number_of_views).to eq 9000
                expect(updated_post.user_account_id).to eq 2
            end
        end
    end
end