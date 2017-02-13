class AddRoomRefToStudentChecks < ActiveRecord::Migration
  def change
    add_reference :student_checks, :room, foreign_key: true 
  end
end
