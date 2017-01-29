class ChangeNameOfCompleteOnStudentChecks < ActiveRecord::Migration
  def change
    rename_column :student_checks, :complete, :complete_status
  end
end
