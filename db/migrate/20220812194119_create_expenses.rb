class CreateExpenses < ActiveRecord::Migration[6.0]
  def change
    create_table :expenses do |t|
      t.integer :type_of_expense
      t.string :description
      t.datetime :date
      t.string :provider_document
      t.string :provider_name
      t.decimal :value
      t.string :document_url
      t.references :deputy, null: false, foreign_key: true

      t.timestamps
    end
  end
end
