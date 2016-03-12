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
            row :program
            row :successful do |resource|
              resource.successful ? status_tag("Yes", :yellow) : status_tag("No", :red)
            end
            row :params
            row :stdout
            row :stderr
            row :directory_snapshot
          end
        end
      end

      column span: 1 do
      end
    end
  end
end
