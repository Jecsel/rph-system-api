class PatientController < ApplicationController
    before_action :must_be_authenticated
    
    def index

    end

    def create
        begin
            if !User.exists?(username: create_params[:first_name])
                user = User.create(
                    username: create_params[:first_name],
                    password: 'rph12345678',
                    user_type_id: 1,
                    user_role_id: 1,
                    is_active: true
                )
            end
    
            if user.save!
                profile = Profile.create(
                    user_id: user.id,
                    surname: create_params[:surname],   
                    first_name: create_params[:first_name],
                    middle_name: create_params[:middle_name],
                    dob: create_params[:dob],
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
    
                render json: {message: 'Patient Profile Created', profile: profile},status: 200
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

    def show
    end

    private

    def create_params
        params
            .require(:profile)
            .permit(:surname, :first_name, :middle_name, :dob, :age, :birth_place, :gender_id, :civil_status_id, :occupation, :religion, :nationality, :cp_no, :employed_by, :person_to_notify, :person_to_notify_address, :person_to_notify_no, :person_to_notify_cp_relationship)

    end
end
