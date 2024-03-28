# frozen_string_literal: true

class AddRecStudentTable < ActiveRecord::Migration[7.0]
  def change
    create_table :recommended_students do |t|
      t.string :student_email, null: false
      t.foreign_key :users, column: :student_email, primary_key: :email
      t.references :instructor_rec, foreign_key: true, null: false

      t.timestamps
    end
  end
end
