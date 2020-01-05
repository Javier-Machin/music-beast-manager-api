class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
  # POST /signup
  # return authenticated token upon signup
  def create
    user = User.create!(user_params)
    auth_response = AuthenticateUser.new(user.email, user.password).call
    response = { 
      message: Message.account_created, 
      auth_token: auth_response[:token], 
      user_name: auth_response[:user_name] 
    }
    json_response(response, :created)
  end

  private

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
