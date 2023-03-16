class CreateCourseTalents < ActiveRecord::Migration[6.1]
  def change
    create_table :course_talents do |t|
      t.references :talent, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.boolean :completed, null: false, default: false

      t.timestamps
    end
  end
end
