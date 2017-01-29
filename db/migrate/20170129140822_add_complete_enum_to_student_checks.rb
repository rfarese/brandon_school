class AddCompleteEnumToStudentChecks < ActiveRecord::Migration
  def change
    add_column :student_checks, :complete, :integer, default: 0
  end
end
