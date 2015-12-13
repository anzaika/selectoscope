class AddOutputToCodemlResult < ActiveRecord::Migration
  def change
    add_column :codeml_results, :output, :text
  end
end
