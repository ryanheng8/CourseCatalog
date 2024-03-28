# frozen_string_literal: true

class CreateStudentApps < ActiveRecord::Migration[7.0]
  def change
    create_table :student_apps do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :student_email, null: false
      t.string :campus_name, null: false
      t.string :term, null: false
      t.string :preferred_course, null: false
      t.foreign_key :users, column: :student_email, primary_key: :email

      t.timestamps
    end
  end
end
