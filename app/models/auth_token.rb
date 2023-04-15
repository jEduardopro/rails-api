class AuthToken < ApplicationRecord

	validates :token, presence: true, uniqueness: true
end