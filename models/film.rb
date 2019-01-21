require "pg"
class Film
  attr_accessor :id, :title, :body

  def self.open_connection
    return PG.connect(dbname: "films", user: "postgres", password: "password")
  end

  def self.all
    conn = self.open_connection

    sql = "SELECT * FROM films ORDER BY id;"

    results = conn.exec(sql)

    films = results.map do |tuple|
      self.hydrate tuple
    end
  end

  def self.hydrate film_data
    film = Film.new

    film.id = film_data["id"]
    film.title = film_data["title"]
    film.body = film_data["body"]

    return film
  end

  def self.find id
    # open connection to database

    conn = self.open_connection
    # query the database
    sql = "SELECT * FROM films WHERE id = #{id};"

    result = conn.exec(sql).first

    film = self.hydrate result
    return film
  end

  def save
      conn = Film.open_connection
      if !self.id
      # class method for the self class
      # can call self.open connection on a open method, self refers to the instance you're calling, open conection is a method for the film class

      sql = "INSERT INTO films(title, body) VALUES('#{self.title}','#{self.body}');"
      else
        sql = "UPDATE films SET title = '#{self.title}',body ='#{self.body}' WHERE id = #{self.id};"
      end
      conn.exec(sql)
  end

  def self.delete id
    conn = self.open_connection

    sql = "DELETE FROM films WHERE id = #{id};"

    conn.exec sql
  end
end
