ActiveAdmin.register RunProfile do
  permit_params :id,
                :name,
                :description,
                run_profile_tool_links: %i(id run_profile_id tool_id)

  filter :name

  index do
    selectable_column
    column :name
    actions
  end

  show do
    columns do
      column span: 1 do
        panel "General" do
          row :name
          row :description
        end
      end
      column span: 1 do
        panel "Tools" do
          row :tool_for_alignment
          row :tool_for_tree
          row :tool_for_selection
        end
      end
    end
  end

  form do |f|
    columns do
      column span: 1 do
      end
      column span: 1 do
      end
    end
  end

end
