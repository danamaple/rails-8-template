# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  outreaches_count       :integer
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string
#  smtp_address           :string
#  smtp_from_email        :string
#  smtp_password          :string
#  smtp_port              :integer
#  smtp_username          :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many  :outreaches,  class_name: "Outreach",  foreign_key: "rep_id", dependent: :destroy
  has_many  :email_sends, class_name: "EmailSend", foreign_key: "user_id"

  def smtp_configured?
    smtp_address.present? && smtp_username.present? && smtp_password.present?
  end
end
