class User < ActiveRecord::Base
  belongs_to :credit_company
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :role, presence: true, if: :approved
  before_save :temp_authorized, if: :new_record?

  def self.find_all_by_approved status
    where approved: status
  end

  def active_for_authentication? 
    super && (approved? || email == Rails.application.config.superadmin)
  end 

  def inactive_message 
    if !approved? 
      :not_approved 
    else 
      super # Use whatever other message 
    end 
  end

  def temp_authorized
    self.approved = true
    self.role = :company_user
  end
  
end
