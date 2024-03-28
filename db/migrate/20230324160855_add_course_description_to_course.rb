# frozen_string_literal: true

class AddCourseDescriptionToCourse < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :course_description, :string
  end
end
