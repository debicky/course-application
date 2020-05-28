class HomeController < ApplicationController
skip_before_action :authenticate_user!, only: [:index]


  def index
    @courses = Course.all.limit(3)
    @latest_courses = Course.published.approved.limit(3).order("created_at DESC")
    @enrollments = Enrollment.reviewed.order(rating: :desc).limit(3)
    @top_rated_courses = Course.published.approved.order(average_rating: :desc, created_at: :desc).limit(3)
    @popular_courses = Course.published.approved.order(enrollments_count: :desc, created_at: :desc).limit(3)
    @purchased_courses = Course.joins(:enrollments).where(enrollments: {user: current_user}).order(created_at: :desc).limit(3)
  end

  def activity
    @pagy, @activities = pagy(PublicActivity::Activity.all.order(created_at: :desc))
  end
end

