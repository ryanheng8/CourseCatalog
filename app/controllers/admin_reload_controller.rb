# frozen_string_literal: true

class AdminReloadController < ApplicationController
  # reloads the course catalog
  def reload_page
    authorize! :manage, :all

    selectedTerm = params[:term]
    selectedCampus = params[:campus]
    termBool = ['Summer 2023', 'Spring 2023', 'Autumn 2023'].include?(selectedTerm)
    campusBool = %w[Columbus Newark Lima Marion Wooster Mansfield].include?(selectedCampus)

    # If both options have a valid campus/course we are able to delete and reload
    if termBool && campusBool

      Section.where(campus_name: selectedCampus, term: selectedTerm).destroy_all
      Course.where(id: Section.where(campus_name: selectedCampus, term: selectedTerm).pluck(:course_id)).destroy_all

      # hashs so we can get a temp value for the api request
      hashCampus = { 'Columbus' => 'col', 'Newark' => 'nwk', 'Lima' => 'lma', 'Marion' => 'mrn', 'Wooster' => 'wst', 'Mansfield' => 'mns' }
      hashTerm = { 'Spring 2023' => '1232', 'Summer 2023' => '1234', 'Autumn 2023' => '1238' }

      tempCampusName = hashCampus[selectedCampus]
      tempTermName = hashTerm[selectedTerm]

      # Requesting the api
      ApiClient.get_data('https://content.osu.edu/v2/classes/search',
                         { q: 'cse', term: tempTermName, campus: tempCampusName })

      redirect_to :catalog, notice: 'Success!'

    else
      # If nothing was deleted or loaded then render with no success
      render 'reload-page', notice: 'Unsuccessful...'
    end
  end
end
