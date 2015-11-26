class User < ActiveRecord::Base

    before_save :downcase_email
    before_create :setup_activation
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

	validates :password, length: {minimum: 6}

	has_secure_password

    has_many :job_posts

	attr_accessor :remember_token, :activation_token
	
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    def authenticated?(attribute, token)
    	digest = send("#{attribute}_digest")
    	return false if digest.nil?
           BCrypt::Password.new(digest).is_password?(token)
    end

    def User.token
    	SecureRandom.base64
    end

    def remember
    	@remember_token = User.token
    	update_attribute(:remember_digest, User.digest(remember_token))
    end

    def setup_activation
        self.activation_token  = User.token
        self.activation_digest = User.digest(activation_token)
    end

    def forget
    	update_attribute(:remember_digest, nil)
    end

    def downcase_email
      self.email = self.email.downcase
    end

end
