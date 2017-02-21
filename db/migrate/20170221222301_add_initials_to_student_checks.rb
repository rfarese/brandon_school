class AddInitialsToStudentChecks < ActiveRecord::Migration
  def change
    add_column :student_checks, :initials, :string
  end
end
