class RenameIdDeputyToNumberDeputy < ActiveRecord::Migration[6.0]
  def change
    rename_column :deputies, :id_deputy, :number_deputy
  end
end
