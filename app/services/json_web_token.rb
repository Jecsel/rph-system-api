class JsonWebToken
    SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
    RSA_PRI = OpenSSL::PKey::RSA.generate 2048
    RSA_PUB = RSA_PRI.public_key
  
    def self.encode(payload)
      payload[:exp] = 24.hours.from_now.to_i
      payload[:iat] = 0.hours.from_now.to_i
      payload[:token_use] = "access"
      JWT.encode(payload, SECRET_KEY)
    end
  
    def self.decode(token)
      decoded = JWT.decode(token, SECRET_KEY)[0]
      HashWithIndifferentAccess.new decoded
    end
end