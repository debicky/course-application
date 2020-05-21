class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def edit?
    @record.user == @user || @user.has_role?(:admin)
  end
  
  def update?
    @record.user == @user || @user.has_role?(:admin)
  end
  
  def new?
    @user.has_role?(:teacher)
  end
  
  def create?
    @user.has_role?(:teacher)
  end
  
  def destroy?
    @record.user == @user || @user.has_role?(:admin)
  end

  def admin_or_owner?
    @user.has_role?(:admin) || @record.user == @user
  end

end
