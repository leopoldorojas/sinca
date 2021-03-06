class User < ActiveRecord::Base
  belongs_to :credit_company
  has_many :credit_companies, foreign_key: "executive_id"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_validation { self.role ||= :company_user }
  validates :credit_company, :role, presence: :true
  #before_save :temp_authorized, if: :new_record?
  default_scope { order(:name) }

  scope :find_all_by_approved, ->(status) { where approved: status }
  scope :executives, -> { where role: [:analytic_executive, :executive, :admin] }

  def to_s
    name
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

  def is_at_least? minimum_role
    Rails.application.config.user_roles[role.to_sym][:privilege] >= Rails.application.config.user_roles[minimum_role.to_sym][:privilege]
  end

  def has_more_privileges_than? minor_role
    Rails.application.config.user_roles[role.to_sym][:privilege] > Rails.application.config.user_roles[minor_role.to_sym][:privilege]
  end

  def is_at_most? maximum_role
    Rails.application.config.user_roles[role.to_sym][:privilege] <= Rails.application.config.user_roles[maximum_role.to_sym][:privilege]
  end

  def is? specific_role
    Rails.application.config.user_roles[role.to_sym][:privilege] == Rails.application.config.user_roles[specific_role.to_sym][:privilege]
  end

  def is_not? specific_role
    Rails.application.config.user_roles[role.to_sym][:privilege] != Rails.application.config.user_roles[specific_role.to_sym][:privilege]
  end

  def temp_authorized
    self.approved = true
    self.role = :company_user
  end
  
end
