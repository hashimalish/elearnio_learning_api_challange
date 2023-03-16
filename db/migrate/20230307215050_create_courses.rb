class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.references :learning_path, foreign_key: true
      t.references :author, polymorphic: true
      t.integer :position, index: true

      t.timestamps
    end
  end
end
