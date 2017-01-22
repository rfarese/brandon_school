class RemovePolymorphicRelationshipFromStudentChecks < ActiveRecord::Migration
  def up
    remove_index :student_checks, name: "index_student_checks_on_checkable_type_and_checkable_id"
    remove_column :student_checks, :checkable_id, :integer
    remove_column :student_checks, :checkable_type, :string
  end

  def down
    add_index :student_checks, name: "index_student_checks_on_checkable_type_and_checkable_id"
    add_column :student_checks, :checkable_id, :integer
    add_column :student_checks, :checkable_type, :string 
  end
end
