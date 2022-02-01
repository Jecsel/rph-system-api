class OutpatientRecord < ApplicationRecord
    has_many            :outpatient_record_remarks
    has_many            :outpatient_clinics
    has_many            :outpatient_clinic_services
end
