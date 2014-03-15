class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.datetime :scheduled_at
      t.boolean :canceled
      t.references :user, index: true

      t.timestamps
    end
  end
end
