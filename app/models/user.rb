class User < ApplicationRecord
    before_create :encrypt_password
    has_one             :profile
    belongs_to          :user_type
    belongs_to          :user_role
    belongs_to          :building
    has_many            :clinical_record
    has_many            :outpatient_record
    
    def valid_password? password
        self.password === Digest::MD5.hexdigest(password)[0..19]
    end

    def has_profile
        self.profile.present?
    end

    private
    
    def encrypt_password
        self.password = Digest::MD5.hexdigest(self.password)[0..19]
    end
end
