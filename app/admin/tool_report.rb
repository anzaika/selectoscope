ActiveAdmin.register ToolReport do
  filter :program

  index do
    selectable_column
    column :tool
    column :group
    column :successful
    column :created_at
    actions
  end

  show do |report|
    columns do
      column span: 1 do
        panel "General info" do
          attributes_table_for report do
            row :program
            row :exec
            row :version
            row :successful do |resource|
              resource.successful ? status_tag("Yes", :yellow) : status_tag("No", :red)
            end
            row :params
            row :directory_snapshot
          end
        end
      end
      column span: 1 do
        report.text_files.each do |file|
          panel file.meta, "data-panel" => :collapsed do
            file.web_view
          end
        end
      end
    end
    # columns do
    #   column span: 1 do
    #     panel "Output" do
    #       div class: "mono" do
    #         report.stdout
    #       end
    #     end
    #   end
    #
    #   column span: 1 do
    #     panel "Errors" do
    #       div class: "mono" do
    #         report.stderr
    #       end
    #     end
    #   end
    # end
  end
end
