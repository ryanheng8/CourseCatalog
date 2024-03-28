# frozen_string_literal: true

class AddCatalogNumber < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :catalog_number, :integer
  end
end
