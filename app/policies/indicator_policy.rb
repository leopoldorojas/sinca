class IndicatorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.has_more_privileges_than? :company_admin
        scope.all
      else
        scope.where(credit_company: user.credit_company)
      end
    end
  end

  def create?
    user.is_at_least? :superadmin
  end

  def edit?
    user.is_at_least? :executive
  end

  def destroy?
    user.is_at_least?(:executive) || record.register_date >= Time.zone.now.at_beginning_of_month
  end
end
