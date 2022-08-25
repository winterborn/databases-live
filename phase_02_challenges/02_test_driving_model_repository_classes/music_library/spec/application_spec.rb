# require "./application"

# RSpec.describe Application do
#     context "albums" do
#         it "returns a list of album titles based on terminal input" do
#             io = double :io
#             expect(io).to receive(:puts).with("Welcome to the music library manager!\n\n")
#             expect(io).to receive(:puts).with("What would you like to do?\n\n        1 - List all albums\n\n        2 - List all artists\n\n")
#             expect(io).to receive(:puts).with("Enter your choice:\n")
#             expect(io).to receive(:gets).and_return(1)
#             expect(io).to receive(:puts).with("Here is a list of albums:")
          
#             repo_album = AlbumRepository.new
#             repo_artist = ArtistRepository.new
#             application = Application.new("music_library", io, repo_album, repo_artist)
#             application.run
#         end
#     end
# end