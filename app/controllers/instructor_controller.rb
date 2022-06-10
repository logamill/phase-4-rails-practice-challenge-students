class InstructorController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with :record_invalid
    
    def index 
        instructors = Instructor.all 
        render json: instructors
    end

    def show 
        instructor = find_instructor
        render json: instructor
    end

    def create
        instructor = Instructor.create(instructor_params)
        render json: instructor, status: :created 
    end

    def update 
        instructor = find_instructor
        instructor.update(instructor_params)
        render json: instructor
    end

    def destroy 
        instructor = find_instructor
        instructor.destroy 
        render json: {}
    end

    private 

    def render_not_found_response
        render json: { error: "#{object} not found"}, status: :not_found 
    end

    def record_invalid(exception)
        render json: {error: exception }, status: :unprocessable_entity

    def find_instructor
        Instructor.find(params[:id])
    end
    
    def instructor_params
        params.permit(:name)
    end

end
