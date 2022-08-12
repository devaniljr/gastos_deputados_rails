class CreateDeputies < ActiveRecord::Migration[6.0]
  def change
    create_table :deputies do |t|
      t.integer :id_deputy
      t.string :name
      t.string :state
      t.string :party
      t.integer :legislature
      t.string :civil_name
      t.string :photo_url
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
