class Profile < ApplicationRecord
    include SearchCop
    has_one_attached :avatar
    
    search_scope :search do
      attributes :surname, :first_name, :middle_name, :birth_place, :occupation, :nationality, :cp_no, :employed_by, :person_to_notify
    end
end
