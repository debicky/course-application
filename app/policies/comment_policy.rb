class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  
  def destroy?
    @user.present? && @user.has_role?(:admin) || 
    @user.present? && @record.course.user_id == @user.id ||
    @user.present? && @record.user_id == @user.id

  end


end
