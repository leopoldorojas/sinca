class CreditCompanyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def manage?
    user.is_at_least? :admin
  end

  def see_only_own_company?
  	user.is_at_most? :company_admin
  end
end
