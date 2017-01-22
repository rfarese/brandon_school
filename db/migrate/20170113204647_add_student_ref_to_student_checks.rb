class AddStudentRefToStudentChecks < ActiveRecord::Migration
  def change
    add_reference :student_checks, :student, foreign_key: true 
  end
end
