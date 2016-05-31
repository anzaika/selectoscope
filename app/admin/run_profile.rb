ActiveAdmin.register RunProfile do
  permit_params :id,
                :name,
                :description,
                :tool_for_alignment_id,
                :tool_for_tree_id,
                :tool_for_selection_id

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
          attributes_table_for run_profile do
            row :name
            row :description
          end
        end
      end
      column span: 1 do
        panel "Tools" do
          table_for run_profile.tools do |tool|
            column :name
            column :type
          end
        end
      end
    end
  end

  form do |f|
    columns do
      column span: 1 do
        inputs "Base" do
          f.input :name
          f.input :description
        end
        actions
      end
      column span: 1 do
        f.inputs "Tools" do
          input :tool_for_alignment_id, as: :select, collection: Tool.for_alignment
          input :tool_for_tree_id, as: :select, collection: Tool.for_tree
          input :tool_for_selection_id, as: :select, collection: Tool.for_selection
        end
      end
    end
  end

  controller do
    def create
      @run_profile = RunProfile.new(permitted_params["run_profile"])
      @run_profile.user_id = current_user.id
      if @run_profile.save
        redirect_to @run_profile
      else
        flash[:errors] = @run_profile.errors.messages
        render("new")
      end
    end
  end

end
