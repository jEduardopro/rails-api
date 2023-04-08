require 'bcrypt'

class User < ApplicationRecord
  # users.password_hash in the database is a :string
  include BCrypt

	def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end

	# has_secure_password
	
	validates :name, presence: true
	validates :email, presence: true, uniqueness: true

	has_one :address
	has_many :funnels
	has_many :pages, through: :funnels

end
