class AuthController < ApplicationController
    before_action :must_be_authenticated, only:[:authenticate]

  def index
    # @users = User.all
    # render 'index.json.jbuilder'
  end

  def get_users
    # @users = User.all
    # render 'get_users.json.jbuilder'
  end

  def sign_in
    user = User.find_by_username user_params[:username]
    if user.present?
        p user.valid_password?(user_params[:password])
      if user.valid_password?(user_params[:password])
        user.user_token = Generator.new().generate_alpha_numeric
        user.save!
        @bearer_token = encode({user_id: user.id,secret: user.user_token})
        if user.has_profile
          render json: { bearer_token: @bearer_token, user_id: user.id, has_profile: user.has_profile, profile_id: user.profile.id },status:200
        else
          render json: { bearer_token: @bearer_token, user_id: user.id, has_profile: user.has_profile},status:200
        end
      else
        p "invalid pass"
        invalid_account
      end
    else
        p "NOT FOUND"
        account_not_found
    end
  end

  def authenticate
    # #return admin user information here
    render json: {message: :accepted}
  end

  def register

    if !User.exists?(username: create_params[:username])

      @user = User.create(username: create_params[:username], password: create_params[:password], user_type_id: create_params[:user_type_id], user_role_id:create_params[:user_role_id], building_id: create_params[:building_id], is_active: true)

      render json: { message: "Successfully registered", status: true }
    else
      code_500("Username already exists.")
    end
    
  end

  def sign_out

  end
  
  private 
  

  def set_new_pass user
    render json: {message:"Set new password"}
    return false
  end

  def invalid_account
    render json: {message:"Invalid Account"},status:403 #forbidden
    return false
  end

  def account_not_found
    render json: {message:"User Not Found"},status:404 #forbidden
    return false
  end

  def code_500 msg
    render json: {messge: msg},status:500 #forbidden
    return false
  end

  def code_200 msg
    render json: {message: msg},status:200
    return false
  end

  def edit_params
    params.require(:user).permit(:id, :username, :user_group_id, :is_active)
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def create_params
    params.require(:user).permit(:username, :password, :user_type_id, :user_role_id, :building_id)
  end
end
