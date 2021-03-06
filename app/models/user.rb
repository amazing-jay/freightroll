class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates_uniqueness_of :email, allow_blank: true

  has_many :shipments, dependent: :destroy

  validates_format_of :phone, with: /\d{10}/

  after_save do
    send_sms_code(phone) if saved_change_to_attribute?(:mfa_code)
  end

  # poorly named function that only exists to meet ticket specification; should be refactored
  def send_sms_code(_phone_number)
    SendMfaCodeJob.perform_later self
  end

  def reset_mfa_code
    self.mfa_code = rand.to_s[2,6]
    self.mfa_code_expiration_at = 10.minutes.from_now
  end

  def valid_mfa_code?(verification_code)
    verification_code == mfa_code && mfa_code_expiration_at > DateTime.current
  end

  def email_required?
    false
  end

  def password_required?
    email.present?
  end

  def display_name
    email.presence || formatted_phone
  end

  def formatted_phone
    "+1 (#{phone[0..2]}) #{phone[3..5]}-#{phone[6...]}"
  end
end
