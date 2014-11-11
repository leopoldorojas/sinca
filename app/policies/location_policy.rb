class LocationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def manage?
    user.at_least? :admin
  end
end
