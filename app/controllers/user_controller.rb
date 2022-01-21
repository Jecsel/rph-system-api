class UserController < ApplicationController
    before_action :must_be_authenticated 

    def index
        users = User.all
        render json: { user:users },status: 200
    end

    def update_user
        user = User.find_by_id user_params[:user_id]
        p user
        if user.present?
            user.update( user_role_id: user_params[:user_role_id], user_type_id: user_params[:user_type_id], is_active: user_params[:is_active])
            json_response(200, "User Updated")
        else
            error_404
        end
    end

    private

    def user_params
        params.require(:user).permit(:user_id, :user_role_id, :user_type_id, :is_active)
    end

end
