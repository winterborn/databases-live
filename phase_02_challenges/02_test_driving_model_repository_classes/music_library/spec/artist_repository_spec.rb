require "artist_repository"

RSpec.describe ArtistRepository do
  def reset_artists_table
    seed_sql = File.read("spec/seeds_artists.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "music_library_test" })
    connection.exec(seed_sql)
  end

  describe ArtistRepository do
    before(:each) { reset_artists_table }

    context "#all method" do
    it "returns a list of artists" do
      repo = ArtistRepository.new
      artists = repo.all
      expect(artists.length).to eq (2)
      expect(artists.first.id).to eq ("1")
      expect(artists.first.name).to eq ("Radiohead")
    end
  end

    context "#find method" do
    it "returns Blink-182 as the first artist" do
      repo = ArtistRepository.new
      artists = repo.find(1)

      expect(artists.name).to eq "Radiohead"
      expect(artists.genre).to eq "Alternative"
    end

    it "returns Toto as the second artist" do
      repo = ArtistRepository.new
      artists = repo.find(2)

      expect(artists.name).to eq "Toto"
      expect(artists.genre).to eq "Alternative"
    end
  end

  context "#create method" do
    it "creates a new artist" do
      repo = ArtistRepository.new
      new_artist = Artist.new
      new_artist.name = "The Cure"
      new_artist.genre = "Alternative"

      repo.create(new_artist)

      artists = repo.all
      last_artist = artists.last

      expect(last_artist.name).to eq "The Cure"
      expect(last_artist.genre).to eq "Alternative"
    end
  end

  context "#delete method" do
    it "deletes an artist with id = 1" do
      repo = ArtistRepository.new

      id_to_delete = 1

      repo.delete(id_to_delete)

      all_artists = repo.all
      expect(all_artists.length).to eq 1
      expect(all_artists.first.id).to eq '2'
    end

    it "deletes the two artists" do
      repo = ArtistRepository.new
      repo.delete(1)
      repo.delete(2)

      all_artists = repo.all
      expect(all_artists.length).to eq 0
    end
  end

  context "#update method" do
    it "updates the artist given an id, with new values" do
      repo = ArtistRepository.new

      artist = repo.find(1)

      artist.name = 'Something else'
      artist.genre = 'New genre'

      repo.update(artist)

      updated_artist = repo.find(1)

      expect(updated_artist.name).to eq "Something else"
      expect(updated_artist.genre).to eq "New genre"
    end

    it "updates the artist given an id, with new name only" do
      repo = ArtistRepository.new

      artist = repo.find(1)

      artist.name = 'Something else'

      repo.update(artist)

      updated_artist = repo.find(1)

      expect(updated_artist.name).to eq "Something else"
      expect(updated_artist.genre).to eq "Alternative"
    end
  end
  end
end
