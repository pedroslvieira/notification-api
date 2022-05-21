class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :description
      t.datetime :date

      t.timestamps
    end
  end
end
