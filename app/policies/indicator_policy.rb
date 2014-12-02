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
    user.is_at_least?(:executive) && specific_policy_for_analytic_executives
  end

  def block_allowed_fields?
    user.is_not? :superadmin
  end

  def destroy?
    edit? || (record.register_date >= Time.zone.now.at_beginning_of_month && user.is_not?(:analytic))
  end

  def upload?
    user.is_not? :analytic
  end

  private

    def specific_policy_for_analytic_executives
      user.is?(:analytic_executive) ? record.credit_company == user.credit_company : true
    end

end
