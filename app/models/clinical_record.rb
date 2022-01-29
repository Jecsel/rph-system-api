class ClinicalRecord < ApplicationRecord
    has_one                 :clinical_outpatient_profile
    has_many                :clinical_record_department
    has_many                :clinical_record_society_class
    has_many                :clinical_record_local_service
    has_many                :clinical_record_result
    has_many                :clinical_record_disposition

end
