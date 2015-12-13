ActiveAdmin.register RunReport do
  filter :program

  index do
    selectable_column
    column :program
    column :version
    column :runtime
    column :finish
    actions
  end

  show do |report|
    columns do
      column span: 1 do
        panel "All" do
          attributes_table_for report do
            row :params
            row :stdout
            row :stderr
          end
        end
      end

      column span: 1 do
      end
    end
  end
end
