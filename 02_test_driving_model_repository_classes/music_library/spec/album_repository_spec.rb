require "album_repository"

RSpec.describe AlbumRepository do
  def reset_albums_table
    seed_sql = File.read("spec/seeds_albums.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "music_library_test" })
    connection.exec(seed_sql)
  end

  describe AlbumRepository do
    before(:each) { reset_albums_table }

    context "#all method" do
    it "returns a list of albums" do
      repo = AlbumRepository.new
      albums = repo.all
      expect(albums.length).to eq (2)
      expect(albums.first.id).to eq ("1")
      expect(albums.first.title).to eq ("OK Computer")
    end
  end

    context "#create method" do
      it "creates a new album" do
        repo = AlbumRepository.new
        new_album = Album.new
        new_album.title = 'Take off Your Pants and Jacket'
        new_album.release_year = '2001'
        new_album.artist_id = '5'

        repo.create(new_album)

        all_albums = repo.all
        expect(all_albums).to include (
          have_attributes(
            title: new_album.title = 'Take off Your Pants and Jacket',
            release_year: new_album.release_year = '2001',
            artist_id: new_album.artist_id = '5'
          )
        )
      end
    end
  end
end
