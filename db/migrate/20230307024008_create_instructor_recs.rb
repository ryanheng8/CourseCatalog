# frozen_string_literal: true

class CreateInstructorRecs < ActiveRecord::Migration[7.0]
  def change
    create_table :instructor_recs do |t|
      t.string :instructor_email, null: false
      t.foreign_key :users, column: :instructor_email, primary_key: :email
      t.boolean :specific_student_request_flag

      t.timestamps
    end
  end
end
