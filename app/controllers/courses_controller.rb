class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index]


  # GET /courses
  # GET /courses.json
  def index
    @courses_ransack_path = courses_path
    @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search)
    #@courses = @ransack_courses.result.includes(:user).order("created_at DESC")
    @pagy, @courses = pagy(@ransack_courses.result.includes(:user).order("created_at DESC"))


  end
  
  # GET /courses/1
  # GET /courses/1.json
  def show
    @lessons = @course.lessons
  end

  def purchased
    @courses_ransack_path = purchased_courses_path
    @pagy, @courses = pagy(Course.joins(:enrollments).where(enrollments: {user: current_user}))
    render 'index'
  end
  
  def pending_review
    @courses_ransack_path = pending_review_courses_path
    @pagy, @courses = pagy(Course.joins(:enrollments).merge(Enrollment.pending_review.where(user: current_user)))
    render 'index'
  end
  
  def created
    @courses_ransack_path = created_courses_path
    @pagy, @courses = pagy(Course.where(user: current_user))
    render 'index'
  end
  
  # GET /courses/new
  def new
    @course = Course.new
    authorize @course
  end

  # GET /courses/1/edit
  def edit
    authorize @course
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    authorize @course
    @course.user = current_user

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    authorize @course
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    authorize @course
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:title, :description, :user_id, :short_description, :language, :price, :level)
    end
end
