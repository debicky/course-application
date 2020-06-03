class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy, :delete_video]


  def delete_video
    authorize @lesson, :edit? 
    @lesson.video.purge
    @lesson.video_thumbnail.purge
    redirect_to edit_course_lesson_path(@course, @lesson), notice: "Video deleted."
  end

  def sort
    @course = Course.friendly.find(params[:course_id])
    lesson = Lesson.friendly.find(params[:lesson_id])
    authorize lesson, :edit?
    lesson.update(lesson_params)
    render body: nil
  end

  # GET /lessons
  # GET /lessons.json
  def index
    @lessons = Lesson.all
  end
  
  # GET /lessons/1
  # GET /lessons/1.json
  def show
    authorize @lesson
    current_user.view_lesson(@lesson)
    @lessons = @course.lessons.rank(:row_order)
    @comment = Comment.new
    @comments = @lesson.comments
  end

  # GET /lessons/new
  def new
    @course = Course.friendly.find(params[:course_id])
    @lesson = Lesson.new
  end

  # GET /lessons/1/edit
  def edit
    authorize @lesson
  end
  
  # POST /lessons
  # POST /lessons.json
  def create
    @course = Course.friendly.find(params[:course_id])
    @lesson = Lesson.new(lesson_params)
    @lesson.course_id = @course.id
    authorize @lesson

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to course_path(@course), notice: 'Lesson was successfully created.' }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    @course = Course.friendly.find(params[:course_id])
    authorize @lesson
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to course_path(@course), notice: 'Lesson was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    authorize @lesson
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to course_path(@course), notice: 'Lesson was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.friendly.find(params[:id])
      @course = Course.friendly.find(params[:course_id])
    end

    # Only allow a list of trusted parameters through.
    def lesson_params
      params.require(:lesson).permit(:title, :content, :row_order_position, :video, :video_thumbnail)
    end
end
