require_relative "./artists"

class ArtistRepository
  def all
    sql = "SELECT id, name, genre FROM artists ORDER BY id;"
    result_set = DatabaseConnection.exec_params(sql, [])

    artists = []

    result_set.each do |record|
      artist = Artist.new
      artist.id = record["id"]
      artist.name = record["name"]
      artist.genre = record["genre"]

      artists << artist
    end

    # puts artists.first.name
    return artists
  end

  def find(id)
    sql = "SELECT id, name, genre FROM artists WHERE id = $1;"
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]

    artist = Artist.new
    artist.id = record["id"]
    artist.name = record["name"]
    artist.genre = record["genre"]

    return artist
  end

  def create(artist)
    sql = "INSERT INTO artists (name, genre) VALUES($1, $2);"
    sql_params = [artist.name, artist.genre]
    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def delete(id)
    sql = "DELETE FROM artists WHERE id = $1;"
    sql_params = [id]
    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def update(artist)
    sql = "UPDATE artists SET name = $1, genre = $2 WHERE id = $3;"
    sql_params = [artist.name, artist.genre, artist.id]
    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end
end
