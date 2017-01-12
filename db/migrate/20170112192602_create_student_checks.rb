class CreateStudentChecks < ActiveRecord::Migration
  def change
    create_table :student_checks do |t|
      t.string :status, null: false
      t.text :comment
      t.integer :checkable_id
      t.string :checkable_type

      t.timestamps null: false
    end

    add_index :student_checks, [:checkable_type, :checkable_id]
  end
end
