class ChangeCompleteToEnumOnStudentChecks < ActiveRecord::Migration
  def change
    remove_column :student_checks, :complete, :boolean
  end
end
