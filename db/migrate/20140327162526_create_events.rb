class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.column :description, :string
      t.column :location, :string
      t.column :start_date_time, :datetime
      t.column :end_date_time, :datetime
      t.column :user_id, :integer
      t.timestamps
      end
      create_table :users do |t|
        t.column :name, :string
        t.timestamps
    end
  end
end
