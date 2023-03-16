class CreateLearningPaths < ActiveRecord::Migration[6.1]
  def change
    create_table :learning_paths do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
