class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_test_user, only: [:edit, :destroy]

  def authenticate_test_user
    if current_user == User.find(1)
      redirect_to root_path
    end
  end

  protected

  def update_resource(resource, params)
    return super if params["password"]
    resource.update_without_password(params.except("current_password"))
  end
end
