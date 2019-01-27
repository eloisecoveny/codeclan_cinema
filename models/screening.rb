require_relative("../db/sql_runner")

class Screening

  attr_accessor :screening_time, :film_id, :sold
  attr_reader :id, :capacity

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @screening_time = options["screening_time"]
    @film_id = options["film_id"].to_i
    @sold = options["sold"].to_i
    @capacity = 2
  end

  def save()
    sql = "INSERT INTO screenings (screening_time, film_id, sold) VALUES ($1, $2, $3) RETURNING id"
    values = [@screening_time, @film_id, @sold]
    @id = SqlRunner.run(sql, values)[0]["id"].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    screenings = SqlRunner.run(sql)
    return screenings.map { |screening| Screening.new(screening) }
  end

  def update()
    sql = "UPDATE screenings SET (screening_time, film_id, sold) = ($1, $2, $3) WHERE id = $4"
    values = [@screening_time, @film_id, @sold, @id]
    SqlRunner.run(sql, values)
  end

  def tickets_sold()
    sql = "SELECT * FROM tickets WHERE screening_id = $1"
    values = [@id]
    tickets = SqlRunner.run(sql, values)
    return tickets.map { |ticket| Ticket.new(ticket) }
  end

  def no_tickets_sold()
    tickets_sold.length()
  end

end
