class EnrollmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end


  def index?
    @user.has_role?(:admin)
  end

  def edit?
    @record.user == @user || @user.has_role?(:admin)
  end
  
  def update?
    @record.user_id == @user.id || @user.has_role?(:admin)
  end
    
  def destroy?
    @user.has_role?(:admin)
  end


end