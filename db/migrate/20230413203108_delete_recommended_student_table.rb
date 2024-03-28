# frozen_string_literal: true

class DeleteRecommendedStudentTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :recommended_students
  end
end
