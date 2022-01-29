class ProfileController < ApplicationController
    before_action :must_be_authenticated

    def index
        @profiles = Profile.all.order('created_at DESC')
        render json: {profiles: @profiles},status: 200
    end

    def create
        begin
            p create_params
            if @current_user.profile.nil?
                profile = Profile.create(
                    user_id: create_params[:user_id],
                    surname: create_params[:surname],   
                    first_name: create_params[:first_name],
                    middle_name: create_params[:middle_name],
                    dob: create_params[:dob].to_date + 1.days,
                    age: create_params[:age],
                    birth_place: create_params[:birth_place],
                    gender_id: create_params[:gender_id],
                    civil_status_id: create_params[:civil_status_id],
                    occupation: create_params[:occupation],
                    religion: create_params[:religion],
                    nationality: create_params[:nationality],
                    cp_no: create_params[:cp_no],
                    employed_by: create_params[:employed_by],
                    person_to_notify: create_params[:person_to_notify],
                    person_to_notify_address: create_params[:person_to_notify_address],
                    person_to_notify_no: create_params[:person_to_notify_no],
                    person_to_notify_cp_relationship: create_params[:person_to_notify_cp_relationship]
                )

                render json: {message: 'Profile Created', profile: profile},status: 200
            else
                render json: {message: 'Already have a profile', profile: profile, profile_id: profile.id},status: 200
            end
            
        rescue StandardError => e
            p e.to_s
            render json: {
                error: e.to_s
              }, status: 500
        end
    end

    def update_profile
        begin
            profile = Profile.find(update_params[:id])
            profile.update(
                surname: update_params[:surname],
                first_name: update_params[:first_name],
                middle_name: update_params[:middle_name],
                dob: update_params[:dob].to_date + 1.days,
                age: update_params[:age],
                birth_place: update_params[:birth_place],
                gender_id: update_params[:gender_id],
                civil_status_id: update_params[:civil_status_id],
                occupation: update_params[:occupation],
                religion: update_params[:religion],
                nationality: update_params[:nationality],
                cp_no: update_params[:cp_no],
                employed_by: update_params[:employed_by],
                person_to_notify: update_params[:person_to_notify],
                person_to_notify_address: update_params[:person_to_notify_address],
                person_to_notify_no: update_params[:person_to_notify_no],                    
                person_to_notify_cp_relationship: update_params[:person_to_notify_cp_relationship]
            )
            render json: { message: 'Profile Updated', profile: profile},status: 200

        rescue StandardError => e
            p e.to_s
            render json: {
                error: e.to_s
              }, status: 500
        end
    end

    def show
        profile = Profile.find params[:id]
        render json: {profile: profile}, status: 200
    end

    def get_user_profile
        p @current_user
        profile = @current_user.profile
        render json: {profile: profile}, status: 200
    end

    def has_profile
        if @current_user.nil?
            render json: { has_profile: false },status: 200
        else
            render json: { has_profile: true },status: 200
        end
    end

    private

    def create_params
        params
            .require(:profile)
            .permit(:user_id, :surname, :first_name, :middle_name, :dob, :age, :birth_place, :gender_id, :civil_status_id, :occupation, :religion, :nationality, :cp_no, :employed_by, :person_to_notify, :person_to_notify_address, :person_to_notify_no, :person_to_notify_cp_relationship)
    end

    def update_params
        params
            .require(:profile)
            .permit(:user_id, :surname, :first_name, :middle_name, :dob, :age, :birth_place, :gender_id, :civil_status_id, :occupation, :religion, :nationality, :cp_no, :employed_by, :person_to_notify, :person_to_notify_address, :person_to_notify_no, :person_to_notify_cp_relationship,:id)
    end
end
