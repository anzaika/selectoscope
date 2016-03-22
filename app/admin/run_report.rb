ActiveAdmin.register RunReport do
  filter :program

  index do
    selectable_column
    column :program
    column :successful
    column :runtime
    actions
  end

  show do |report|
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
    columns do
      column span: 1 do
        panel "Output" do
          report.stdout
        end
      end

      column span: 1 do
        panel "Errors" do
          report.stderr
        end
      end
    end
  end
end
