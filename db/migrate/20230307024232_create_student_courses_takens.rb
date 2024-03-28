# frozen_string_literal: true

class CreateStudentCoursesTakens < ActiveRecord::Migration[7.0]
  def change
    create_table :student_courses_takens do |t|
      t.string :student_email, null: false
      t.foreign_key :users, column: :student_email, primary_key: :email
      t.integer :course, null: false
      t.string :grade, null: false

      t.timestamps
    end
  end
end
