class ClinicalRecordController < ApplicationController
    before_action :must_be_authenticated

    def index
        @clinical_records = ClinicalRecord.all
        render json: {clinical_records: @clinical_records},status: 200
    end

    def create
        begin
            clinical_record = ClinicalRecord.new
            clinical_record.patient_id = create_params[:patient_id]
            clinical_record.attending_physician_id = create_params[:attending_physician_id]
            clinical_record.prepared_by_id = create_params[:prepared_by_id]
            clinical_record.fiscal_year = create_params[:fiscal_year]
            clinical_record.hospital_no = create_params[:hospital_no]
            clinical_record.building_id = create_params[:building_id]
            clinical_record.admitted_datetime = create_params[:admitted_datetime]
            clinical_record.transferred_from = create_params[:transferred_from]
            clinical_record.admitting_diagnosis = create_params[:admitting_diagnosis]
            clinical_record.final_diagnosis = create_params[:final_diagnosis]
            clinical_record.management_operations = create_params[:management_operations]
            clinical_record.save

            if clinical_record.save!
                create_params[:departments].each do |dept|
                    c_department = ClinicalRecordDepartment.new
                    c_department.clinical_record_id = clinical_record[:id]
                    c_department.department_id = dept[:department_id]
                    c_department.is_selected = dept[:is_selected]
                    c_department.save
                end
                
                create_params[:society_classes].each do |soc|
                    soc_class = ClinicalRecordSocietyClass.new
                    soc_class.clinical_record_id = clinical_record[:id]
                    soc_class.society_class_id = soc[:society_class_id]
                    soc_class.is_selected = soc[:is_selected]
                    soc_class.save
                end

                create_params[:local_services].each do |loc|
                    loc_service = ClinicalRecordLocalService.new
                    loc_service.clinical_record_id = clinical_record[:id]
                    loc_service.local_service_id = loc[:local_service_id]
                    loc_service.is_selected = loc[:is_selected]
                    loc_service.desc = loc[:desc]
                    loc_service.save
                end

                create_params[:results].each do |res|
                    result = ClinicalRecordResult.new
                    result.clinical_record_id = clinical_record[:id]
                    result.result_id = res[:result_id]
                    result.is_selected = res[:is_selected]
                    result.save
                end

                create_params[:dispositions].each do |dis|
                    dispo = ClinicalRecordDisposition.new
                    dispo.clinical_record_id = clinical_record[:id]
                    dispo.disposition_id = dis[:desposition_id]
                    dispo.is_selected = dis[:is_selected]
                    dispo.desc = dis[:desc]
                    dispo.save
                end

                profile = Profile.find(create_params[:patient_id])

                cor_profile = ClinicalOutpatientProfile.new
                cor_profile.clinical_record_id = clinical_record[:id]
                cor_profile.user_id = profile[:user_id],
                cor_profile.surname =  profile[:surname],
                cor_profile.first_name = profile[:first_name],
                cor_profile.middle_name = profile[:middle_name],
                cor_profile.dob = profile[:dob],
                cor_profile.age = profile[:age],
                cor_profile.birth_place = profile[:birth_place],
                cor_profile.gender_id = profile[:gender_id],
                cor_profile.civil_status_id = profile[:civil_status_id],
                cor_profile.occupation = profile[:occupation],
                cor_profile.religion = profile[:religion],
                cor_profile.nationality = profile[:nationality],
                cor_profile.cp_no = profile[:cp_no],
                cor_profile.employed_by = profile[:employed_by],
                cor_profile.person_to_notify = profile[:person_to_notify],
                cor_profile.person_to_notify_address = profile[:person_to_notify_address],
                cor_profile.person_to_notify_no = profile[:person_to_notify_no],
                cor_profile.person_to_notify_cp_relationship = profile[:person_to_notify_cp_relationship]
                cor_profile.save
            end

            render json: {message: 'Clinical Record Created', profile: clinical_record},status: 200
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
            .require(:clinical_record)
            .permit(:patient_id, :attending_physician_id, :prepared_by_id, :fiscal_year, :hospital_no, :building_id,
                :admitted_datetime, :transferred_from, :admitting_diagnosis, :final_diagnosis, :management_operations,
                :departments => [:department_id, :is_selected],
                :society_classes => [:society_class_id, :is_selected],
                :local_services => [:local_service_id, :is_selected, :desc],
                :results => [:result_id, :is_selected],
                :dispositions => [:disposition_id, :is_selected, :desc])
    end

end
