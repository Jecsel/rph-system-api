class ListController < ApplicationController
    def index
        @user_roles = UserRole.all
        @user_types = UserType.all
        @civil_statuses = CivilStatus.all
        @buildings = Building.all
        @local_services = LocalService.all
        @results = Result.all
        @dispositions = Disposition.all
        @clinic_services = ClinicService.all
        @clinics = Clinic.all
        @departments = Department.all
        @society_classes = SocietyClass.all
        @genders = Gender.all
        @buildings = Building.all
    end

    def get_all_doctor
        @doctors = User.where(user_type_id:3)
    end

end
