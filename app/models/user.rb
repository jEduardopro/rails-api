
class User < ApplicationRecord
  # users.password_hash in the database is a :string

	# rails model validation reference link to search

	PASSWORD_MIN_LENGTH = 6
	PASSWORD_MAX_LENGTH = 15

	attr_accessor :password

	# overrides setter
	def password=(password_str) # rubocop:todo Lint/DuplicateMethods
    unless password_str.blank?
      @password = password_str
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_digest = BCrypt::Engine.hash_secret(password_str, password_salt)
    end
  end

	def authenticate(password)
    password.present? && password_digest.present? && password_digest == BCrypt::Engine.hash_secret(password, password_salt)
  end

	# has_secure_password
	
	validates :name, presence: true
	validates :email, presence: true, uniqueness: true
	validates :password, confirmation: true, 
		length: { in: PASSWORD_MIN_LENGTH..PASSWORD_MAX_LENGTH }, 
		format: { with: /(?=.*[A-Z])/, message: "must contain atleast 1 uppercase letter" },
		unless: :skip_password_validation?
	validates :password_confirmation, presence: true, if: -> {password.present?}
	# validate :password_rules

	has_one :address
	has_many :funnels
	has_many :pages, through: :funnels
	has_many :tokens
	has_many :auth_tokens

	def email_confirmed?
		email_confirmation.present?
	end

	def generate_token
		token = SecureRandom.hex(4)
		tokens.create(token: token)
	end
	

	private 

	def skip_password_validation?
		(password.blank? && password_confirmation.blank?)
	end

	def password_rules
		# At least one upper case English letter, (?=.*?[A-Z])
		# 	At least one lower case English letter, (?=.*?[a-z])
		# 	At least one digit, (?=.*?[0-9])
		# 	At least one special character, (?=.*?[#?!@$%^&*-])
		# 	Minimum eight in length .{8,} (with the anchors)
		password.size < PASSWORD_MIN_LENGTH

	end
	
end
