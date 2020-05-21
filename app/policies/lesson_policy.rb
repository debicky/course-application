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
    @user.has_role?(:teacher)
  end
  
  def create?
    @user.has_role?(:teacher)
  end
  
  def destroy?
    @record.course.user == @user || @user.has_role?(:admin)
  end


end
