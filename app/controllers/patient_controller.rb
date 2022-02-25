class PatientController < ApplicationController
    before_action :must_be_authenticated
    
    def index
        @patients = []
        # if @current_user[:building_id] == 1
        #     @users = User.where(user_type_id: 1, building_id: 1).order('created_at DESC')
        # else
        @users = User.where(user_type_id: 1, is_active: true).order('created_at DESC')
        # end

        @users.each do |user|
            if user.profile.present?
                u = user.profile
                # u.building = user.building_id
                @patients << u
            end
        end

        render json: {patients: @patients},status: 200
    end

    def show_all_nurses
        @nurses = []
        @users = User.where(user_type_id: 2, is_active: true).order('created_at DESC')
        @users.each do |user|
            if user.profile.present?
                u = user.profile
                @nurses << u
            end
        end
        render json: {patients: @nurses},status: 200
    end

    def show_all_doctors
        @doctors = []
        @users = User.where(user_type_id: 3, is_active: true).order('created_at DESC')
        @users.each do |user|
            if user.profile.present?
                u = user.profile
                @doctors << u
            end
        end
        render json: {patients: @doctors},status: 200
    end

    def show_all_admins
        @admins = []
        @users = User.where(user_type_id: 4, is_active: true).order('created_at DESC')
        @users.each do |user|
            if user.profile.present?
                u = user.profile
                @admins << u
            end
        end
        render json: {patients: @admins},status: 200
    end

    def update_doctor_is_online
        begin
            doc = Profile.find params[:id]
            doc.update(is_online: params[:is_online])
        rescue StandardError => e
            p e.to_s
            render json: {
                error: e.to_s
            }, status: 500
        end
    end

    def update_nurse_is_online
        begin
            nurse = Profile.find params[:id]
            nurse.update(is_online: params[:is_online])
        rescue StandardError => e
            p e.to_s
            render json: {
                error: e.to_s
            }, status: 500
        end
    end

    def update_admin_is_online
        begin
            admin = Profile.find params[:id]
            admin.update(is_online: params[:is_online])
        rescue StandardError => e
            p e.to_s
            render json: {
                error: e.to_s
            }, status: 500
        end
    end

    def create
        begin
            a = ('A'..'Z').to_a.sample(10) 
            b = (0..9).to_a.sample(10)
            c = a + b
            c.sample(20).join()
            if User.where(username: create_params[:first_name]).count == 0
                user = User.create(
                    username: c,
                    password: 'rph12345678',
                    user_type_id: 1,
                    user_role_id: 1,
                    building_id: 1,
                    is_active: true
                )

                if user.profile.nil?
                    profile = Profile.create(
                        user_id: user.id,
                        surname: create_params[:surname],   
                        first_name: create_params[:first_name],
                        middle_name: create_params[:middle_name],
                        dob: create_params[:dob].to_date + 1.days,
                        age: create_params[:age],
                        address: create_params[:address],
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
            else
                render json: {message: 'Username Already Taken'},status: 200
            end
        rescue StandardError => e
            p e.to_s
            render json: {
                error: e.to_s
            }, status: 500
        end
    end

    def create_nurse
        begin
            a = ('A'..'Z').to_a.sample(10) 
            b = (0..9).to_a.sample(10)
            c = a + b
            c.sample(20).join()
            if User.where(username: create_params[:first_name]).count == 0
                user = User.create(
                    username: c,
                    password: 'rph12345678',
                    user_type_id: 2,
                    user_role_id: 1,
                    building_id: 1,
                    is_active: true
                )

                if user.profile.nil?
                    profile = Profile.create(
                        user_id: user.id,
                        surname: create_params[:surname],   
                        first_name: create_params[:first_name],
                        middle_name: create_params[:middle_name],
                        dob: create_params[:dob].to_date + 1.days,
                        age: create_params[:age],
                        address: create_params[:address],
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
                    render json: {message: 'Nurse Profile Created', profile: profile},status: 200
                else
                    render json: {message: 'Already have a profile', profile: profile, profile_id: profile.id},status: 200
                end
            else
                render json: {message: 'Username Already Taken'},status: 200
            end
        rescue StandardError => e
            p e.to_s
            render json: {
                error: e.to_s
            }, status: 500
        end
    end

    def create_doctor
        begin
            a = ('A'..'Z').to_a.sample(10) 
            b = (0..9).to_a.sample(10)
            c = a + b
            c.sample(20).join()
            if User.where(username: create_params[:first_name]).count == 0
                user = User.create(
                    username: c,
                    password: 'rph12345678',
                    user_type_id: 3,
                    user_role_id: 1,
                    building_id: 1,
                    is_active: true
                )

                if user.profile.nil?
                    profile = Profile.create(
                        user_id: user.id,
                        surname: create_params[:surname],   
                        first_name: create_params[:first_name],
                        middle_name: create_params[:middle_name],
                        dob: create_params[:dob].to_date + 1.days,
                        age: create_params[:age],
                        address: create_params[:address],
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
                    render json: {message: 'Doctor Profile Created', profile: profile},status: 200
                else
                    render json: {message: 'Already have a profile', profile: profile, profile_id: profile.id},status: 200
                end
            else
                render json: {message: 'Username Already Taken'},status: 200
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

    def filter_patient
        begin
            @patients = []
            @users = []

            if params[:building_id] == 0
                @users = User.where(user_type_id: 1).order('created_at DESC')
            else
                @users = User.where(user_type_id: 1, building_id: params[:building_id]).order('created_at DESC')
            end
            
            @users.each do |user|
                if user.profile.present?
                    u = user.profile
                    @patients << u
                end
            end
    
            render json: { patients: @patients },status: 200
        rescue StandardError => e
            p e.to_s
            render json: {
                error: e.to_s
            }, status: 500
        end
    end

    def patient_search
        
        begin
            @profiles = Profile.search(params[:search_key])
            render json: { patients: @profiles },status: 200
        rescue StandardError => e
            p e.to_s
            render json: { error: e.to_s }, status: 500
        end
    end

    private

    def create_params
        params
            .require(:profile)
            .permit(:surname, :first_name, :middle_name, :dob, :age, :birth_place, :address, :gender_id, :civil_status_id, :occupation, :religion, :nationality, :cp_no, :employed_by, :person_to_notify, :person_to_notify_address, :person_to_notify_no, :person_to_notify_cp_relationship)

    end
end
