ActiveAdmin.register Identifier do
  permit_params :id,
                :name

  index do
    selectable_column
    column :name
    column :codename
    actions
  end

  filter :name

  show do |org|
    columns do
      column span: 1 do
        panel "Basic" do
          attributes_table_for org do
            row :name
          end
        end
      end
    end
  end
end
