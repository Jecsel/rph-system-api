class UserController < ApplicationController
    before_action :must_be_authenticated 

    def index
        users = User.all.where(is_active: true)
        render json: { user:users },status: 200
    end

    def update_user
        user = User.find_by_id update_params[:id]
        if user.present?
            if user.password != update_params[:password]
                user.update( 
                    username: update_params[:username],
                    password: Digest::MD5.hexdigest(update_params[:password])[0..19],
                    user_role_id: update_params[:user_role_id],
                    user_type_id: update_params[:user_type_id],
                    is_active: update_params[:is_active])
                json_response(200, "User Updated")
            else
                user.update( 
                    username: update_params[:username],
                    password: update_params[:password],
                    user_role_id: update_params[:user_role_id],
                    user_type_id: update_params[:user_type_id],
                    is_active: update_params[:is_active])
                json_response(200, "User Updated")
            end
        else
            error_404
        end
    end

    def deactivate_user
        begin
            user = User.find_by_id(params[:id])
            user.update(is_active: false)
            json_response(200, "User Deleted")
        rescue StandardError => e
            p e.to_s
            render json: {
                error: e.to_s
            }, status: 500
        end
    end

    private

    def user_params
        params.require(:user).permit(:user_id, :user_role_id, :user_type_id, :is_active)
    end

    def update_params
        params.require(:user).permit(:id, :username, :password, :user_token, :user_role_id, :user_type_id, :is_active)
    end
end
