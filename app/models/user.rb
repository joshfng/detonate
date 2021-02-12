class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  has_many :switches

  encrypts :email, :unconfirmed_email
  blind_index :email, :unconfirmed_email
end
