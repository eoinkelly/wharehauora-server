# frozen_string_literal: true
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true

  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :home_viewers, dependent: :destroy

  # TODO: homes they own as well
  has_many :homes, through: :home_viewers

  def role?(role)
    roles.any? { |r| r.name == role }
  end
end
