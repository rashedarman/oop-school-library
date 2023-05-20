require_relative 'app'

OPTIONS = {
  'Please choose an option by entering a number:' => '',
  'List all books' => :list_books,
  'List all people' => :list_people,
  'Create a person' => :create_person,
  'Create a book' => :create_book,
  'Create a rental' => :create_rental,
  'List all rentals for a given person id' => :list_rentals,
  'Exit' => :exit_app
}.freeze

def main
  app = App.new

  puts 'Welcome to School Library App!'
  selected_option = -1

  until selected_option == OPTIONS.length - 1
    print_options(OPTIONS)

    selected_option = app.input('number', 1..(OPTIONS.length - 1)).to_i
    selected_method = OPTIONS.values[selected_option]
    app.send(selected_method)
  end
end

def print_options(options)
  options.each_with_index do |(option_key, _), index|
    puts "#{index.zero? ? '' : "#{index} - "}#{option_key}"
  end
end

main
