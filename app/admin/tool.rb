ActiveAdmin.register Tool do
  permit_params :id,
                :name,
                :description,
                :class_name,
                :type

  filter :name
  filter :type, as: :select, collection: Tool.types

  index do
    selectable_column
    column :name
    column :type
    column :class_name
    actions
  end

  show do
    columns do
      column span: 1 do
        panel "Base" do
          attributes_table_for tool do
            row :name
            row :type
            row :class_name
          end
        end
      end
      column span: 2 do
      end
    end
  end

  form do |f|
    columns do
      column span: 1 do
        inputs "Base" do
          input :name
          input :type, as: :select, collection: Tool.types
          input :class_name
        end
        actions
      end
      column span: 2 do
      end
    end
  end
end
