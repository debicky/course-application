class UsersController < ApplicationController 
    def index
      #@users = User.order("created_at DESC")

      @q = User.ransack(params[:q])
      @users = @q.result(distinct: true)
    end
  end
  