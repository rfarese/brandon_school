class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :initials, null: false, limit: 3
      t.belongs_to :bed, index: true

      t.timestamps null: false
    end
  end
end
