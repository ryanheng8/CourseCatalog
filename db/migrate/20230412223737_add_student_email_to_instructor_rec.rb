# frozen_string_literal: true

class AddStudentEmailToInstructorRec < ActiveRecord::Migration[7.0]
  def change
    add_column :instructor_recs, :student_email, :string
    add_foreign_key :instructor_recs, :users, column: 'student_email', primary_key: 'email'
  end
end
