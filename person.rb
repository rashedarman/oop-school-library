require_relative './nameable'
require_relative './decorators'

class Person < Nameable
  attr_accessor :name, :age, :rentals, :parent_permission
  attr_reader :id

  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @age = age
    @name = name
    @parent_permission = parent_permission
    @rentals = []
  end

  def correct_name
    @name
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  def of_age?
    @age >= 18
  end
  private :of_age?

  def add_rental(rental)
    @rentals << rental
    rental.person = self
  end
end

person = Person.new(22, 'maximilianus')
person.correct_name
capitalized_person = CapitalizeDecorator.new(person)
capitalized_person.correct_name
capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
capitalized_trimmed_person.correct_name

p person
