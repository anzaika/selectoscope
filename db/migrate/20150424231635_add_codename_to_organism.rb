class AddCodenameToOrganism < ActiveRecord::Migration
  def change
    add_column :organisms, :codename, :string
  end
end
