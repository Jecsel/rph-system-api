class DashboardController < ApplicationController
    # before_action :must_be_authenticated

    def index
        @patients = []
        @doctors = []
        @nurses = []
        @admins = []
        online_doctors = []
        online_admins = []
        online_nurses = []

        doctor = User.where(user_type:3, is_active: true)
        patient = User.where(user_type:1, is_active: true)
        nurse = User.where(user_type_id:2, is_active: true)
        admin = User.where(user_type_id:4, is_active: true)
        recovered = ClinicalRecordResult.where(result_id:1, is_selected: true).count
        improved = ClinicalRecordResult.where(result_id:2, is_selected: true).count
        unimproved = ClinicalRecordResult.where(result_id:3,is_selected: true).count
        died = ClinicalRecordResult.where(result_id:4,is_selected: true).count

        
        patient.each do |pat|
            if pat.profile.present?
                u = pat.profile
                @patients << u
            end
        end

        doctor.each do |doc|
            if doc.profile.present?
                u = doc.profile
                if u.is_online
                    online_doctors << u
                end
                @doctors << u
            end
        end

        nurse.each do |nur|
            if nur.profile.present?
                u = nur.profile
                if u.is_online
                    online_nurses << u
                end
                @nurses << u
            end
        end

        admin.each do |adm|
            if adm.profile.present?
                u = adm.profile
                if u.is_online
                    online_admins << u
                end
                @admins << u
            end
        end

        render json: {
            doctor: @doctors.count,
            patient: @patients.count,
            nurse: @nurses.count,
            admin: @admins.count,
            online_doctors: online_doctors.count,
            online_nurses: online_nurses.count,
            online_admins: online_admins.count,
            recovered: recovered,
            improved: improved,
            unimproved: unimproved,
            died: died
        },status:200
    end

end
