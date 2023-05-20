require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'

require 'pry'

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def list_books
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_people
    @people.each do |person|
      puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_person
    puts "Create a person"
    puts "1. Student"
    puts "2. Teacher"
    option = input('number', 1..2)

    print "Age: "
    age = input('number', 1..1000)

    print "Name: "
    name = input('string', /^[\w\s]+$/)

    case option
    when 1
      print "Has parent permission? [Y/N]: "
      parent_permission = input('string', /^[ynYN]$/i)
      @people.push(Student.new(age, name, parent_permission: parent_permission.downcase == 'y'))
    when 2
      puts "Specialization: "
      specialization = input('string', /^\w+$/)
      @people.push(Teacher.new(specialization, age, name))
    end

    puts "Person created"
  end

  def create_book
    puts "Create a book"
    print "Title: "
    title = input('string', /^[\w\s]+$/)

    print "Author: "
    author = input('string', /^[\w\s]+$/)

    @books.push(Book.new(title, author))
    puts "Book created"
  end

  def create_rental
    puts "Create a rental"

    puts "Select a book from the following list by number"
    @books.each_with_index do |book, index|
      puts "#{index}) Title: #{book.title}, Author: #{book.author}"
    end
    book_index = input('number', 0..(@books.length - 1))

    puts ""

    puts "Select a person from the following list by number (not id)"
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_index = input('number', 0..(@people.length - 1))

    puts ""

    puts "Date(YYYY/MM/DD): "
    date = input('string', /^\d{4}\/\d{2}\/\d{2}$/)

    @rentals.push(Rental.new(date, @books[book_index], @people[person_index]))
    puts "Rental created"
  end

  def list_rentals
    puts "List all rentals for a given person id"
    print "ID of person: "
    person_id = input('number', 1..1000)

    puts "Rentals:"
    filtered_mapped_rentals = @rentals.filter_map do |rental|
      rental_info = rental_info(rental)
      rental_info if rental.person.id == person_id
    end
    puts filtered_mapped_rentals
  end

  def exit_app
    puts "Exited"
  end

  def input(type, range_or_regex)
    input_value = gets.chomp

    case type
    when 'number'
      input_value = input_value.to_i
      until input_value.is_a?(Integer) && range_or_regex.include?(input_value)
        puts "Invalid input. Please enter a number within the specified range: #{range_or_regex}"
        input_value = gets.chomp.to_i
      end
    when 'string'
      until input_value.match?(range_or_regex)
        puts "Invalid input. Please enter a string that matches the required format: #{range_or_regex}"
        input_value = gets.chomp
      end
    end

    input_value
  end

  def rental_info(rental)
    "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}"
  end
end
