# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, #, :registerable,
         :recoverable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable

  has_many :switches, dependent: :destroy

  encrypts :email, :unconfirmed_email
  blind_index :email, :unconfirmed_email

  validates :email, presence: true
  validates :email, uniqueness: true
end
