class RemoveStudentIdFromStudentChecks < ActiveRecord::Migration
  def change
    remove_column :student_checks, :student_id, :integer
  end
end
