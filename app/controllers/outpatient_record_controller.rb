class OutpatientRecordController < ApplicationController
    before_action :must_be_authenticated
    def index
        records = []
        @outpatient_records = OutpatientRecord.where(is_active: true).order('created_at DESC')
        
        @outpatient_records.each do |outpatient|
            p outpatient
            records << { 
                record: outpatient,
                clinics: outpatient.outpatient_clinics,
                clinic_service: outpatient.outpatient_clinic_services,
                profile: User.find(outpatient[:patient_id]).profile,
                remarks: outpatient.outpatient_record_remarks}
        end
        render json: {outpatient_records: records},status: 200
    end

    def show
        begin
            outpatient_record = OutpatientRecord.find(params[:id])

            render json: {outpatient_record: outpatient_record, outpatient_record_remarks: outpatient_record.outpatient_record_remarks},status: 200
        rescue StandardError => e
            p e.to_s
            render json: {
                error: e.to_s
            }, status: 500
        end
    end

    def show_patient_outpatient_records
        begin
            records = []
            outpatient_records = OutpatientRecord.where(patient_id: params[:outpatient_record_id], is_active: true).order('created_at DESC')
            outpatient_records.each do |outpatient|
                p outpatient
                records << { 
                    record: outpatient,
                    clinics: outpatient.outpatient_clinics,
                    clinic_service: outpatient.outpatient_clinic_services,
                    profile: User.find(outpatient[:patient_id]).profile,
                    remarks: outpatient.outpatient_record_remarks}
            end
            render json: {outpatient_records: records},status: 200

            # render json: {outpatient_records: outpatient_record},status: 200

        rescue StandardError => e
            p e.to_s
            # render json: {
            #     error: e.to_s
            # }, status: 500
        end
    end

    def create
        begin
            outpatient_record = OutpatientRecord.create(
                patient_id: create_params[:patient_id], 
                physician_id: create_params[:physician_id],
                clinical_record_id: create_params[:clinical_record_id],
                payees_person_to_notify: create_params[:payees_person_to_notify],
                referred_by: create_params[:referred_by],
                relations_to_patient: create_params[:relations_to_patient],
                note_to_allergies: create_params[:note_to_allergies],
                is_release: create_params[:is_release],
                noi: create_params[:noi],
                poi: create_params[:poi],
                doi: create_params[:doi],
                toi: create_params[:toi],
                assailant: create_params[:assailant],
                nearest_kin: create_params[:nearest_kin],
                patient_brought_victim: create_params[:patient_brought_victim],
                address: create_params[:address],
                is_active: true
            )

            create_params[:clinics].each do |c|
                clinic = OutpatientClinic.create(outpatient_record_id: outpatient_record[:id],clinic_id: c[:clinic_id], is_true: c[:is_true])
            end

            create_params[:clinic_services].each do |c|
                clinic = OutpatientClinicService.create(outpatient_record_id: outpatient_record[:id], clinic_service_id: c[:clinic_service_id], is_true: c[:is_true])
            end

            create_params[:outpatient_record_remarks].each do |mark|
                outpatient_record_remark = OutpatientRecordRemark.create(
                    outpatient_record_id: outpatient_record[:id],
                    doctor_on_duty_id: mark[:doctor_on_duty_id],
                    record_date: mark[:record_date],
                    time_of_arrival: mark[:time_of_arrival],
                    time_of_discharge: mark[:time_of_discharge],
                    diagnosis: mark[:diagnosis],
                    service_of_treatment: mark[:service_of_treatment],
                    doctor_on_duty: mark[:doctor_on_duty],
                    remarks: mark[:remarks],
                )
            end

            render json: {outpatient_record: outpatient_record, outpatient_record_remarks: outpatient_record.outpatient_record_remarks },status: 200
            # render json: {message:"nice"}, status: 200
        rescue StandardError => e
            p e.to_s
            render json: {
                error: e.to_s
            }, status: 500
        end

    end

    def update
        outpatient_record = OutpatientRecord.find(update_params[:outpatient_record_id])
        outpatient_record.update(
            physician_id: update_params[:physician_id],
            clinic_id: update_params[:clinic_id],
            clinic_service_id: update_params[:clinic_service_id],
            clinical_record_id: update_params[:clinical_record_id],
            payees_person_to_notify: update_params[:payees_person_to_notify],
            referred_by: update_params[:referred_by],
            relations_to_patient: update_params[:relations_to_patient],
            note_to_allergies: update_params[:note_to_allergies],
            is_release: update_params[:is_release],
            noi: update_params[:noi],
            poi: update_params[:poi],
            doi: update_params[:doi],
            toi: update_params[:toi],
            assailant: update_params[:assailant],
            nearest_kin: update_params[:nearest_kin],
            patient_brought_victim: update_params[:patient_brought_victim],
            address: update_params[:address],
            is_active: true
        )
        p "clinics"
        p update_params[:clinics]
        update_params[:clinics].each do |c|
            clinic = OutpatientClinic.find(c[:id])
            clinic.update(is_true: c[:is_true])
        end

        p "clinic_services"
        p update_params[:clinic_services]
        update_params[:clinic_services].each do |s|
            service = OutpatientClinicService.find(s[:id])
            service.update(is_true: s[:is_true])
        end

        p "outpatient_record_remarks"
        p update_params[:outpatient_record_remarks]
        update_params[:outpatient_record_remarks].each do |mark|
            outpatient_record_remark = OutpatientRecordRemark.find(mark[:id])
            outpatient_record_remark.update(
                doctor_on_duty_id: mark[:doctor_on_duty_id],
                record_date: mark[:record_date],
                time_of_arrival: mark[:time_of_arrival],
                time_of_discharge: mark[:time_of_discharge],
                diagnosis: mark[:diagnosis],
                service_of_treatment: mark[:service_of_treatment],
                doctor_on_duty: mark[:doctor_on_duty],
                remarks: mark[:remarks],
            )
        end

        render json: {outpatient_record: outpatient_record, outpatient_record_remarks: outpatient_record.outpatient_record_remarks },status: 200
    end

    def destroy
        begin
            o_record = OutpatientRecord.find(params[:id])
            o_record.update(is_active: false)
            # o_record.outpatient_record_remarks.destroy_all 
            # o_record.outpatient_clinics.destroy_all
            # o_record.outpatient_clinic_services.destroy_all
            # o_record.destroy
        rescue StandardError => e
            p e.to_s
            render json: {
                error: e.to_s
            }, status: 500
        end
    end

    private

    def create_params
        params
            .require(:outpatient_record)
            .permit(:patient_id, :physician_id, :clinical_record_id,:payees_person_to_notify,:referred_by,:relations_to_patient,:relations_to_patient,:note_to_allergies,:is_release,:noi,:poi,:doi,:toi,:assailant,:nearest_kin,:patient_brought_victim,:address,:clinics => [:clinic_id, :is_true], :clinic_services => [:clinic_service_id, :is_true],:outpatient_record_remarks => [:outpatient_record_id,:doctor_on_duty_id,:record_date,:time_of_arrival,:time_of_discharge,:diagnosis, :service_of_treatment,:doctor_on_duty,:remarks])
    end

    def update_params
        params
            .require(:outpatient_record)
            .permit(:outpatient_record_id, :patient_id, :physician_id, :clinical_record_id,:payees_person_to_notify,:referred_by,:relations_to_patient,:relations_to_patient,:note_to_allergies,:is_release,:noi,:poi,:doi,:toi,:assailant,:nearest_kin,:patient_brought_victim,:address,:clinics => [:id, :outpatient_record_id, :clinic_id, :is_true], :clinic_services => [:id, :outpatient_record_id, :clinic_service_id, :is_true],:outpatient_record_remarks => [:id, :outpatient_record_id, :outpatient_record_remark_id, :outpatient_record_id,:doctor_on_duty_id,:record_date,:time_of_arrival,:time_of_discharge,:diagnosis, :service_of_treatment,:doctor_on_duty,:remarks])
    end


end
