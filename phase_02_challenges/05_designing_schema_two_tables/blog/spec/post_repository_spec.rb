require "post_repository"

RSpec.describe PostRepository do
  def reset_posts_table
    seed_sql = File.read("spec/seeds_blog.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "blog" })
    connection.exec(seed_sql)
  end

  describe PostRepository do
    before(:each) { reset_posts_table }

    context "#all method" do
      it "returns a list of posts" do
        repo = PostRepository.new
        post = repo.all
        expect(post.length).to eq (3)
        expect(post.first.id).to eq (1)
        expect(post.first.title).to eq ("Blog Post 1")
        expect(post.first.content).to eq ("Blog Post Content 1")
      end
    end

    context "#find method" do
      it "returns Blog Post 1 as the first post" do
        repo = PostRepository.new
        posts = repo.find(1)

        expect(posts.title).to eq "Blog Post 1"
        expect(posts.content).to eq "Blog Post Content 1"
      end

      it "returns Blog Post 2 as the second post" do
        repo = PostRepository.new
        posts = repo.find(2)

        expect(posts.title).to eq "Blog Post 2"
        expect(posts.content).to eq "Blog Post Content 2"
      end

      it "returns Blog Post 3 as the third post" do
        repo = PostRepository.new
        posts = repo.find(3)

        expect(posts.title).to eq "Blog Post 3"
        expect(posts.content).to eq "Blog Post Content 3"
      end
    end

    context "#find_with_comments method" do
      it "finds comments with associated posts" do
        repo = PostRepository.new

        post = repo.find_with_comments(1)
        expect(post.title).to eq "Blog Post 1"
        expect(post.content).to eq "Blog Post Content 1"
        expect(post.comments.first.content).to eq "I love this!"
        expect(post.comments.first.author_name).to eq "Phil"
        expect(post.comments.last.content).to eq "I hate this!"
        expect(post.comments.last.author_name).to eq "Kat"
      end

      it "finds comments with associated posts" do
        repo = PostRepository.new

        post = repo.find_with_comments(2)
        expect(post.title).to eq "Blog Post 2"
        expect(post.content).to eq "Blog Post Content 2"
        expect(post.comments.first.content).to eq "Very interesting..."
        expect(post.comments.first.author_name).to eq "Louisa"
      end

      it "finds comments with associated posts" do
        repo = PostRepository.new

        post = repo.find_with_comments(3)
        expect(post.title).to eq "Blog Post 3"
        expect(post.content).to eq "Blog Post Content 3"
        expect(post.comments.first.content).to eq "Boring!!!"
        expect(post.comments.first.author_name).to eq "Will"
      end
    end
  end
end
