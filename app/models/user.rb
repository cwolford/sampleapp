class User < ActiveRecord::Base
	attr_accessible :first, :last, :email, :password, :password_confirmation, :profile
	has_secure_password

	before_save { self.email = email.downcase }
  	before_create :create_remember_token

	before_save { self.email = email.downcase }
	validates :first, :last, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@andover\.edu\z/i
	validates :email, presence:   true,
                	format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    validates :password, :password_confirmation, :presence=>true
	validates :password, length: { minimum: 6 }

	has_many :orders # the ones created by this user
	has_many :orders_users # join table entries for assignments
	has_many :assignments, :through=>:orders_users, :class_name=>'Order', :source=>:order

	def User.new_remember_token
	    SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
	    Digest::SHA1.hexdigest(token.to_s)
	end

	private
		def create_remember_token
	      self.remember_token = User.encrypt(User.new_remember_token)
	    end
end


  
