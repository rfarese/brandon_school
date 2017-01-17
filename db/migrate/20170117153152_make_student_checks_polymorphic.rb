class MakeStudentChecksPolymorphic < ActiveRecord::Migration
  def change
    add_column :student_checks, :checkable_id, :integer
    add_column :student_checks, :checkable_type, :string
  end
end
