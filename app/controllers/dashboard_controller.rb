class DashboardController < ApplicationController
    # before_action :must_be_authenticated

    def index
        doctor = User.where(user_type:3).count
        patient = User.where(user_type:1).count
        nurse = User.where(user_type_id:2).count
        admin = User.where(user_type_id:4).count
        recovered = ClinicalRecordResult.where(result_id:1, is_selected: true).count
        improved = ClinicalRecordResult.where(result_id:2, is_selected: true).count
        unimproved = ClinicalRecordResult.where(result_id:3,is_selected: true).count
        died = ClinicalRecordResult.where(result_id:4,is_selected: true).count

        render json: {
            doctor: doctor,
            patient: patient,
            nurse: nurse,
            admin: admin,
            recovered: recovered,
            improved: improved,
            unimproved: unimproved,
            died: died
        },status:200
    end

end
