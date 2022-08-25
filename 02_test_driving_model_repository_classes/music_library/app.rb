require_relative "lib/database_connection"
require_relative "lib/artist_repository"
require_relative "lib/album_repository"

# Test outputs
DatabaseConnection.connect("music_library")

# artist_repository = ArtistRepository.new
# album_repository = AlbumRepository.new

# artist_repository = ArtistRepository.new
# artist_repository.all.each { |artist| p artist }

# album_repository = AlbumRepository.new
# album_repository.all.each { |album| p album }

# artist = artist_repository.find(3)
# puts "#{artist.name} - #{artist.genre}"


# Create new album and show all:
# new_album = Album.new
# new_album.title = 'Take off Your Pants and Jacket'
# new_album.release_year = '2001'
# new_album.artist_id = '5'
# album_repository.create(new_album)
# album_repository.all.each { |album| p album }