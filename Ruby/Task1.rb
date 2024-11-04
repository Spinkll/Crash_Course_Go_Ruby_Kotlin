require 'date'

class Student
  @@students = []

  attr_reader :surname, :name, :date_of_birth

  def initialize(surname, name, date_of_birth)
    @surname = surname
    @name = name
    @date_of_birth = Date.parse(date_of_birth)

    raise ArgumentError, "Date of birth must be in the past" if @date_of_birth >= Date.today

    add_student
  end

  def calculate_age
    today = Date.today
    age = today.year - @date_of_birth.year
    age -= 1 if today < @date_of_birth.next_year(age)
    age
  end

  def add_student
    if @@students.any? { |student| student == self }
      puts "Student already exists."
    else
      @@students << self
      puts "Added student: #{@name} #{@surname}"
    end
  end

  def self.remove_student(surname, name, date_of_birth)
    @@students.reject! do |student|
      if student.name == name && student.surname == surname && student.date_of_birth == Date.parse(date_of_birth)
        puts "Removed student: #{name} #{surname}"
        true
      else
        false
      end
    end
  end

  def self.get_students_by_age(age)
    @@students.select { |student| student.calculate_age == age }
  end

  def self.get_students_by_name(name)
    @@students.select { |student| student.name == name }
  end

  def self.all_students
    @@students
  end

  def ==(other)
    other.is_a?(Student) &&
      @surname == other.surname &&
      @name == other.name &&
      @date_of_birth == other.date_of_birth
  end

  def to_s
    "#{@surname} #{@name} (DOB: #{@date_of_birth})"
  end
end
