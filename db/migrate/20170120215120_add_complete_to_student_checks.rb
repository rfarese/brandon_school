class AddCompleteToStudentChecks < ActiveRecord::Migration
  def change
    add_column :student_checks, :complete, :boolean
  end
end
