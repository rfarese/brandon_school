class RemovePolymorphicFromStudentChecks < ActiveRecord::Migration
  def up
    remove_column :student_checks, :checkable_id, :integer
    remove_column :student_checks, :checkable_type, :string
  end

  def down
    add_column :student_checks, :checkable_id, :integer
    add_column :student_checks, :checkable_type, :string
  end
end
