class LessonPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    @record.course.user == @user || @user.has_role?(:admin) || @record.course.bought(@user) == true
  end

  def edit?
    @user.present? && @user.has_role?(:admin) || 
    @user.present? && @record.course.user_id == @user.id
  end
  
  def update?
    @record.course.user == @user || @user.has_role?(:admin)
  end
  
  def new?
    @record.course.user == @user || @user.has_role?(:admin)
  end
  
  def create?
    @record.course.user == @user || @user.has_role?(:admin)
  end
  
  def destroy?
    @record.course.user == @user || @user.has_role?(:admin)
  end


end
