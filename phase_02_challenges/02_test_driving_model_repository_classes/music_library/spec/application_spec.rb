require "./application"


RSpec.describe Application do
    def reset_albums_table
        seed_albums = File.read("spec/seeds_albums.sql")
        connection = PG.connect({ host: "127.0.0.1", dbname: "music_library_test" })
        connection.exec(seed_albums)
      end

    def reset_artists_table
        seed_artists = File.read("spec/seeds_artists.sql")
        connection = PG.connect({ host: "127.0.0.1", dbname: "music_library_test" })
        connection.exec(seed_artists)
      end

    describe Application do
      before(:each) do
        reset_albums_table
        reset_artists_table
      end

        context "albums" do
            it "returns a list of album titles based on terminal input" do
                io = double :io
                expect(io).to receive(:puts).with("Welcome to the music library manager!\n\n")
                expect(io).to receive(:puts).with("What would you like to do?\n\n        1 - List all albums\n\n        2 - List all artists\n\n")
                expect(io).to receive(:puts).with("Enter your choice:\n")
                expect(io).to receive(:gets).and_return(1)
                expect(io).to receive(:puts).with("Here is a list of albums:")
                expect(io).to receive(:puts).with("* 1 - OK Computer")
                expect(io).to receive(:puts).with("* 2 - Toto IV")
            
                repo_album = AlbumRepository.new
                repo_artist = ArtistRepository.new
                application = Application.new("music_library_test", io, repo_album, repo_artist)
                application.run
            end
        end

        context "artists" do
            it "returns a list of artist names based on terminal input" do
                io = double :io
                expect(io).to receive(:puts).with("Welcome to the music library manager!\n\n")
                expect(io).to receive(:puts).with("What would you like to do?\n\n        1 - List all albums\n\n        2 - List all artists\n\n")
                expect(io).to receive(:puts).with("Enter your choice:\n")
                expect(io).to receive(:gets).and_return(2)
                expect(io).to receive(:puts).with("Here is a list of artists:")
                expect(io).to receive(:puts).with("* 1 - Radiohead")
                expect(io).to receive(:puts).with("* 2 - Toto")
            
                repo_album = AlbumRepository.new
                repo_artist = ArtistRepository.new
                application = Application.new("music_library_test", io, repo_album, repo_artist)
                application.run
            end
        end
    end
end