class LessonPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    @record.course.user == @user || @user.has_role?(:admin)
  end

  def edit?
    @record.course.user == @user || @user.has_role?(:admin)
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
