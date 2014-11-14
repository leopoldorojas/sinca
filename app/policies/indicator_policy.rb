class IndicatorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.has_more_privileges_than?(:company_admin) && user.is_not?(:executive)
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
    specific_policy = user.is?(:analytic_executive) ? record.credit_company == user.credit_company : true
    user.is_at_least?(:executive) && specific_policy
  end

  def destroy?
    specific_policy = user.is?(:analytic_executive) ? record.credit_company == user.credit_company : true
    specific_policy && (user.is_at_least?(:executive) || (record.register_date >= Time.zone.now.at_beginning_of_month && user.is_not?(:analytic)))
  end

  def upload?
    user.is_not? :analytic
  end

end
