class AddDefaultFalseToCompleteInStudentChecks < ActiveRecord::Migration
  def change
    change_column :student_checks, :complete, :boolean, default: false 
  end
end
