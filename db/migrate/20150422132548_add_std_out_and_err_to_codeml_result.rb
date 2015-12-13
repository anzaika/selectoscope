class AddStdOutAndErrToCodemlResult < ActiveRecord::Migration
  def change
    add_column :codeml_results, :stdout, :text
    add_column :codeml_results, :stderr, :text
  end
end
