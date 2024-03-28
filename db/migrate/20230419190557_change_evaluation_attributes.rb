# frozen_string_literal: true

class ChangeEvaluationAttributes < ActiveRecord::Migration[7.0]
  def change
    change_column_null :evaluations, :instructor_email, true

    remove_foreign_key :evaluations, :users, column: :instructor_email
    add_foreign_key :evaluations, :users, column: :instructor_email, primary_key: :email, on_delete: :nullify
  end
end
