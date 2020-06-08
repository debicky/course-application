class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: [:show, :edit, :update, :destroy, :certificate]
  before_action :set_course, only: [:new, :create]
  skip_before_action :authenticate_user!, only: [:certificate]

  # GET /enrollments
  # GET /enrollments.json
  def index
    @enrollment_ransack_path = enrollments_path
    @ransack_enrollments = Enrollment.ransack(params[:q])
    @pagy, @enrollments = pagy(@ransack_enrollments.result.includes(:user))
    
  end
  
  def my_students
    @enrollment_ransack_path = my_students_enrollments_path
    @ransack_enrollments = Enrollment.joins(:course).where(courses: {user: current_user}).ransack(params[:q])
    @pagy, @enrollments = pagy(@ransack_enrollments.result.includes(:user))
    render 'index'
  end
  
  # GET /enrollments/1
  # GET /enrollments/1.json
  def show
  end
  
  def certificate
    authorize @enrollment, :certificate?
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@enrollment.course.title}, #{@enrollment.user.email}",
        page_size: 'A4',
        template: 'enrollments/certificate.pdf.erb'

      end
    end
  end
  
  # GET /enrollments/new
  def new
    @enrollment = Enrollment.new
  end
  
  # GET /enrollments/1/edit
  def edit
    authorize @enrollment
  end
  
  # POST /enrollments
  # POST /enrollments.json
  def create
    if @course.price > 0
      flash[:alert] = "You can not access paid courses yet."
      redirect_to new_course_enrollment_path(@course)
    else
      @enrollment = current_user.buy_course(@course)
      redirect_to course_path(@course), notice: "You bought course!"
      EnrollmentMailer.student_enrollment(@enrollment).deliver_later
      EnrollmentMailer.teacher_enrollment(@enrollment).deliver_later
    end
  end
  
  # PATCH/PUT /enrollments/1
  # PATCH/PUT /enrollments/1.json
  def update
    authorize @enrollment
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to @enrollment, notice: 'Enrollment was successfully updated.' }
        format.json { render :show, status: :ok, location: @enrollment }
      else
        format.html { render :edit }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /enrollments/1
  # DELETE /enrollments/1.json
  def destroy
    authorize @enrollment
    @enrollment.destroy
    respond_to do |format|
      format.html { redirect_to enrollment_url, notice: 'Enrollment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_course
      @course = Course.friendly.find(params[:course_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def enrollment_params
      params.require(:enrollment).permit(:rating, :review)
    end
end
