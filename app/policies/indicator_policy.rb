class IndicatorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role != 'company_user'
        scope.all
      else
        scope.where(credit_company: user.credit_company)
      end
    end
  end
end
