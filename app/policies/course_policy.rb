class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show? 
    @record.published && @record.approved || 
    @user.present? && @user.has_role?(:admin) || 
    @user.present? && @record.user_id == @user.id || 
    @user.present? && @record.bought(@user) 
  end

  def edit?
    @user.present? && @user.has_role?(:admin) || 
    @user.present? && @record.user_id == @user.id
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

  def admin?
    @user.has_role?(:admin)
  end

  def admin_or_owner?
    @user.has_role?(:admin) || @record.user == @user
  end

end
