require_relative("models/customer")
require_relative("models/film")
require_relative("models/ticket")

require("pry")

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

film1 = Film.new("title" => "Stalker", "price" => "8")
film1.save()

film2 = Film.new("title" => "The Passenger", "price" => "8")
film2.save()

customer1 = Customer.new("name" => "Eloise", "funds" => "12")
customer1.save()

customer2 = Customer.new("name" => "Bobby", "funds" => "10")
customer2.save()

ticket1 = Ticket.new("customer_id" => customer1.id, "film_id" => film1.id)
ticket1.save()

ticket2 = Ticket.new("customer_id" => customer1.id, "film_id" => film2.id)
ticket2.save()

ticket3 = Ticket.new("customer_id" => customer2.id, "film_id" => film1.id)
ticket3.save()


binding.pry
nil
