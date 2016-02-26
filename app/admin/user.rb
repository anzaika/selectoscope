ActiveAdmin.register User do
  menu if: proc { current_user.admin? }
  permit_params :email,
                :password,
                :password_confirmation,
                :role,
                :first_name,
                :last_name

  index download_links: false do
    selectable_column
    column :name
    column :role
    column :email
    column :sign_in_count
    column :current_sign_in_at
    column :created_at
    actions
  end

  filter :first_name_or_last_name_cont, as: :string, label: "name"
  filter :email
  filter :role

  form do |f|
    f.inputs "Admin Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      if current_user.admin?
        f.input :role, as: :select, collection: User::ROLES
      end
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do |user|
    columns do
      column span: 1 do
        panel 'О пользователе' do
          attributes_table_for user do
            row :name
            row :email
            row :role
          end
        end
      end
      column span: 1 do
      end
    end
  end

  controller do
    # def create
    #   @pass = User.generate_password
    #   params[:user][:password] = @pass
    #   params[:user][:password_confirmation] = @pass
    #   @user = User.new(permitted_params[:user])
    #   respond_to do |format|
    #     if @user.save
    #       # UserMailer.welcome_mail(@user, @pass).deliver
    #       format.html { redirect_to(@user, notice: 'Пользователь успешно создан') }
    #     else
    #       format.html { render action: 'new' }
    #     end
    #   end
    # end
    # def update
    #   if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
    #     params[:user].delete("password")
    #     params[:user].delete("password_confirmation")
    #   end
    #   super
    # end
    def update
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end
      super
    end
  end

end
