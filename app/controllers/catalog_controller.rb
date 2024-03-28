# frozen_string_literal: true

class CatalogController < ApplicationController
  before_action :set_recommended_student, only: %i[show edit update destroy]

  # when loading the /catalog page, instance variable @courses will be initialized as all coruses in DB
  # then used in the view to render all the courses and their sections
  def catalog
    @pagy, @courses = pagy(search(params))
  end

  def set_course
    @course = Course.find(params[:id])
  end

  def set_section
    @section = Section.find(params[:id])
  end

  def search(params)
    # search course with the given params that apply
    @courses = Course.search(params)
  end
end
