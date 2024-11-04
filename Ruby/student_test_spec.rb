require 'minitest/spec'
require 'minitest/autorun'
require_relative 'Task1'  

describe Student do
  before do
    @student1 = Student.new("Doe", "John", "2000-05-15")
    @student2 = Student.new("Smith", "Jane", "2002-08-22")
  end

  it 'adds students correctly' do
    Student.all_students.size.must_equal 2
  end

  it 'calculates age correctly' do
    @student1.calculate_age.must_equal 24
  end

  it 'removes a student correctly' do
    Student.remove_student("Doe", "John", "2000-05-15")
    Student.all_students.size.must_equal 1
  end

  it 'gets students by age correctly' do
    students = Student.get_students_by_age(22)
    students.must_include @student2
  end

  it 'gets students by name correctly' do
    students = Student.get_students_by_name("Jane")
    students.must_include @student2
  end

  it 'does not add duplicate students' do
    output = capture_io do
      student_duplicate = Student.new("Doe", "John", "2000-05-15")
    end
    output.join.must_equal "Student already exists.\n"  
    Student.all_students.size.must_equal 2  
  end
end
