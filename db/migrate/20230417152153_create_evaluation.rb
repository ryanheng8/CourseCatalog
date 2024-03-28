# frozen_string_literal: true

class CreateEvaluation < ActiveRecord::Migration[7.0]
  def change
    create_table :evaluations do |t|
      t.string :instructor_email, null: false
      t.string :student_email, null: false
      t.integer :rating
      t.text :comments

      t.foreign_key :users, column: :student_email, primary_key: :email
      t.foreign_key :users, column: :instructor_email, primary_key: :email
      t.references :course, null: false, foreign_key: true
      t.timestamps
    end
  end
end
