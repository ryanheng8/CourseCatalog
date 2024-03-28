# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!

  # load the courses on home
  def home
    @coursesMemory

    # Loading courses and sections into database
    # Term 1232 = Spring, 1234 = Summer, 1238 = Autumn

    # If the initial courses on the OSU course website aren't in the DB, load them in
    # Needs to be updated with a boolean later
    if Course.all.empty?

      # All three terms for Columbus campus
      Rails.application.executor.wrap do
        ApiClient.get_data('https://content.osu.edu/v2/classes/search',
                           { q: 'cse', term: '1232', campus: 'col' })
        ApiClient.get_data('https://content.osu.edu/v2/classes/search',
                           { q: 'cse', term: '1238', campus: 'col' })
        ApiClient.get_data('https://content.osu.edu/v2/classes/search',
                           { q: 'cse', term: '1234', campus: 'col' })
      end

      # All three terms for Newark campus
      Rails.application.executor.wrap do
        ApiClient.get_data('https://content.osu.edu/v2/classes/search',
                           { q: 'cse', term: '1232', campus: 'nwk' })
        ApiClient.get_data('https://content.osu.edu/v2/classes/search',
                           { q: 'cse', term: '1238', campus: 'nwk' })
        ApiClient.get_data('https://content.osu.edu/v2/classes/search',
                           { q: 'cse', term: '1234', campus: 'nwk' })
      end

      # All three terms for Lima campus
      Rails.application.executor.wrap do
        ApiClient.get_data('https://content.osu.edu/v2/classes/search',
                           { q: 'cse', term: '1232', campus: 'lma' })
        ApiClient.get_data('https://content.osu.edu/v2/classes/search',
                           { q: 'cse', term: '1238', campus: 'lma' })
        ApiClient.get_data('https://content.osu.edu/v2/classes/search',
                           { q: 'cse', term: '1234', campus: 'lma' })
      end

      # All three terms for Marion campus
      Rails.application.executor.wrap do
        ApiClient.get_data('https://content.osu.edu/v2/classes/search',
                           { q: 'cse', term: '1232', campus: 'mrn' })
        ApiClient.get_data('https://content.osu.edu/v2/classes/search',
                           { q: 'cse', term: '1238', campus: 'mrn' })
        ApiClient.get_data('https://content.osu.edu/v2/classes/search',
                           { q: 'cse', term: '1234', campus: 'mrn' })
      end

      # All three terms for Wooster campus
      Rails.application.executor.wrap do
        ApiClient.get_data('https://content.osu.edu/v2/classes/search',
                           { q: 'cse', term: '1232', campus: 'wst' })
        ApiClient.get_data('https://content.osu.edu/v2/classes/search',
                           { q: 'cse', term: '1238', campus: 'wst' })
        ApiClient.get_data('https://content.osu.edu/v2/classes/search',
                           { q: 'cse', term: '1234', campus: 'wst' })
      end

      # All three terms for Mansfield campus
      Rails.application.executor.wrap do
        ApiClient.get_data('https://content.osu.edu/v2/classes/search',
                           { q: 'cse', term: '1232', campus: 'mns' })
        ApiClient.get_data('https://content.osu.edu/v2/classes/search',
                           { q: 'cse', term: '1238', campus: 'mns' })
        ApiClient.get_data('https://content.osu.edu/v2/classes/search',
                           { q: 'cse', term: '1234', campus: 'mns' })
      end


    end
    @coursesMemory ||= Course.all
  end
end
