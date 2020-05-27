module CoursesHelper
  def enrollment_button(course)
    if current_user
      if course.user == current_user
        link_to "Check your course statistics", course_path(course)
      elsif course.enrollments.where(user: current_user).any?
        link_to course_path(course) do
          "<i class='fa fa-tasks text-dark'></i>".html_safe +
          " Your course progress is " +
          number_to_percentage(course.progress(current_user), precision: 0)
        end
      elsif course.price > 0
        link_to number_to_currency(course.price), new_course_enrollment_path(course), class: "btn btn-outline-primary"
      else
        link_to "This course is for free!", new_course_enrollment_path(course), class: "btn btn-primary"
      end
    else
      link_to "Check price", new_course_enrollment_path(course), class: "btn btn-primary"
    end
    
  end

  def review_button(course)
    user_course = course.enrollments.where(user: current_user)
    if current_user
      if user_course.any?
        if user_course.pending_review.any?
          link_to edit_enrollment_path(user_course.first) do
            "<i class='fa fa-star text-warning'></i>".html_safe  + 
            " Add a review"
          end
        else
          link_to  enrollment_path(user_course.first) do
            "<i class='fa fa-check text-warning'></i>".html_safe  + 
            " You have left a review! Thanks."
          end
        end
      end
    end
  end
end
