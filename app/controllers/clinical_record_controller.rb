class ClinicalRecordController < ApplicationController
    before_action :must_be_authenticated

    def index
        @clinical_records = ClinicalRecord.all.order('created_at DESC')
        render json: {clinical_records: @clinical_records},status: 200
    end

    def create
        begin
            p "passok-------"
            p create_params[:patient_id]
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
                
                profile = Profile.find(create_params[:profile_id])
                
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

                clinical_record.update(patient_id: profile[:user_id])
                cor_profile.update(user_id: profile[:user_id])
            end

            render json: {message: 'Clinical Record Created', clinical_record: clinical_record},status: 200
        rescue StandardError => e
            p e.to_s
            render json: {
                error: e.to_s
              }, status: 500
        end
    end

    def show
        begin
            clinical_record = ClinicalRecord.find(params[:id])
            render json: { 
                clinical_record: clinical_record,
                departments: clinical_record.clinical_record_department,
                society_classes: clinical_record.clinical_record_society_class,
                local_services: clinical_record.clinical_record_local_service,
                results: clinical_record.clinical_record_result,
                dispositions: clinical_record.clinical_record_disposition,
                profile: clinical_record.clinical_outpatient_profile.last},status: 200
        rescue StandardError => e
            p e.to_s
            render json: {
                error: e.to_s
            }, status: 500
        end
    end

    def filter_clinical
        begin
            @clinical_records = []
            @records = []
            if params[:building_id] == 0
                @clinical_records = ClinicalRecord.all.order('created_at DESC')
            else
                @clinical_records = ClinicalRecord.where(building_id: params[:building_id]).order('created_at DESC')
            end
    
            render json: {clinical_records: @clinical_records},status: 200
        rescue StandardError => e
            p e.to_s
            render json: {
                error: e.to_s
            }, status: 500
        end
    end

    def patient_clinical_records
        begin
            p_clinical_records = ClinicalRecord.where(patient_id: params[:user_id]).order('created_at DESC')
            render json: {clinical_records: p_clinical_records},status: 200
        rescue StandardError => e
            p e.to_s
            render json: {
                error: e.to_s
            }, status: 500
        end
    end

    def update_clinical_record
        begin
            p update_params[:clinical_record_id]
            clinical_record = ClinicalRecord.find(update_params[:clinical_record_id])
            clinical_record.patient_id = update_params[:patient_id]
            clinical_record.attending_physician_id = update_params[:attending_physician_id]
            clinical_record.prepared_by_id = update_params[:prepared_by_id]
            clinical_record.fiscal_year = update_params[:fiscal_year]
            clinical_record.hospital_no = update_params[:hospital_no]
            clinical_record.building_id = update_params[:building_id]
            clinical_record.admitted_datetime = update_params[:admitted_datetime]
            clinical_record.transferred_from = update_params[:transferred_from]
            clinical_record.admitting_diagnosis = update_params[:admitting_diagnosis]
            clinical_record.final_diagnosis = update_params[:final_diagnosis]
            clinical_record.management_operations = update_params[:management_operations]
            clinical_record.save

            if clinical_record.save!
                
                update_params[:departments].each do |dept|
                    c_department = ClinicalRecordDepartment.find(dept[:id])
                    c_department.update(is_selected: dept[:is_selected])
                end
                
                update_params[:society_classes].each do |soc|
                    p "======= update dispo id ======"
                    soc_class = ClinicalRecordSocietyClass.find(soc[:id])
                    p soc_class
                    soc_class.update(is_selected: soc[:is_selected])
                end

                update_params[:local_services].each do |loc|
                    loc_service = ClinicalRecordLocalService.find(loc[:id])
                    loc_service.update(is_selected: loc[:is_selected], desc: loc[:desc])
                end

                update_params[:results].each do |res|
                    result = ClinicalRecordResult.find(res[:id])
                    result.update(is_selected: res[:is_selected])
                end

                update_params[:dispositions].each do |dis|
                    dispo = ClinicalRecordDisposition.find(dis[:id])
                    dispo.update(is_selected: dis[:is_selected], desc: dis[:desc])
                end
            end

            render json: {message: 'Clinical Record Updated', profile: clinical_record},status: 200
        rescue StandardError => e
            p e.to_s
            render json: {
                error: e.to_s
              }, status: 500
        end
    end

    private

    def update_params
        params
            .require(:clinical_record)
            .permit(:clinical_record_id,:patient_id, :attending_physician_id, :prepared_by_id, :fiscal_year, :hospital_no, :building_id,
                :admitted_datetime, :transferred_from, :admitting_diagnosis, :final_diagnosis, :management_operations,
                :departments => [:id, :department_id, :is_selected],
                :society_classes => [:id, :society_class_id, :is_selected],
                :local_services => [:id, :local_service_id, :is_selected, :desc],
                :results => [:id, :result_id, :is_selected],
                :dispositions => [:id, :disposition_id, :is_selected, :desc])
    end
    
    def create_params
        params
            .require(:clinical_record)
            .permit(:profile_id, :patient_id, :attending_physician_id, :prepared_by_id, :fiscal_year, :hospital_no, :building_id,
                :admitted_datetime, :transferred_from, :admitting_diagnosis, :final_diagnosis, :management_operations,
                :departments => [:department_id, :is_selected],
                :society_classes => [:society_class_id, :is_selected],
                :local_services => [:local_service_id, :is_selected, :desc],
                :results => [:result_id, :is_selected],
                :dispositions => [:disposition_id, :is_selected, :desc])
    end

end
