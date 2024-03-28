# frozen_string_literal: true

class CreateSectionInsutrctors < ActiveRecord::Migration[7.0]
  def change
    create_table :section_instructors do |t|
      t.references :section, null: false, foreign_key: true
      t.string :instructor_email, null: false
      t.foreign_key :users, column: :instructor_email, primary_key: :email

      t.timestamps
    end
  end
end
