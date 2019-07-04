class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.string :name
      t.text :description
      t.decimal :cost
      t.integer :user_id
      t.timestamps
    end
    add_index :issues, :user_id
  end
end
