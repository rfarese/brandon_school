class AddTourRefToStudentChecks < ActiveRecord::Migration
  def change
    add_reference :student_checks, :tour, foreign_key: true
  end
end
