class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index 
        students = Student.all
        render json: students
    end

    def show 
        student = find_student
        render json: student
    end

    def create
        student = Student.create!(student_params)
        render json: student, status: :created 
    end

    def update 
        student = find_student
        student.update(student_params)
        render json: student
    end

    def destroy
        student = find_student
        student.destroy
        render json: {}
    end


    private

    def render_not_found_response
        render json: { error: "Student not found"}, status: :not_found
    end

    def record_invalid(exception)
        render json: { error: exception}, status: :unprocessable_entity
    end

    def find_student 
        Student.find(params[:id])
    end

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end
end
