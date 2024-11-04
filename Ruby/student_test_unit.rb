require 'minitest/autorun'
require_relative 'Task1'  # Подключаем ваш класс Student

class StudentTest < Minitest::Test
  def setup
    @student1 = Student.new("Doe", "John", "2000-05-15")
    @student2 = Student.new("Smith", "Jane", "2002-08-22")
  end

  def test_student_addition
    assert_equal 2, Student.all_students.size
  end

  def test_student_age_calculation
    assert_equal 24, @student1.calculate_age
  end

  def test_student_removal
    Student.remove_student("Doe", "John", "2000-05-15")
    assert_equal 1, Student.all_students.size
  end

  def test_get_students_by_age
    students = Student.get_students_by_age(22)
    assert_includes students, @student2
  end

  def test_get_students_by_name
    students = Student.get_students_by_name("Jane")
    assert_includes students, @student2
  end

  def test_duplicate_student_addition
    output = capture_io do
      student_duplicate = Student.new("Doe", "John", "2000-05-15")
    end
    assert_equal "Student already exists.\n", output.join  
    assert_equal 2, Student.all_students.size  
  end
end
