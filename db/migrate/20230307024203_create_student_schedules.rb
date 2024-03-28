# frozen_string_literal: true

class CreateStudentSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :student_schedules do |t|
      t.string :student_email, null: false
      t.string :day, null: false
      t.string :start_time, null: false
      t.string :end_time, null: false
      t.foreign_key :users, column: :student_email, primary_key: :email

      t.timestamps
    end
  end
end
