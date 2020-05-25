module CoursesHelper
  def enrollment_button(course)
    if current_user
      if course.user == current_user
        link_to "Check your course statistics", course_path(course)
      elsif course.enrollments.where(user: current_user).any?
        link_to "You already bough this course.", course_path(course)
      elsif course.price > 0
        link_to number_to_currency(course.price), new_course_enrollment_path(course), class: "btn btn-outline-primary"
      else
        link_to "This course is for free!", new_course_enrollment_path(course), class: "btn btn-primary"
      end
    else
      link_to "Check price", new_course_enrollment_path(course), class: "btn btn-primary"
    end
    
  end
end
