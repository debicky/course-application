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

  def certificate?
    @record.course.lessons_count == @record.course.user_lessons.where(user: @record.user).count
  end
    
  def destroy?
    @user.has_role?(:admin)
  end


end
