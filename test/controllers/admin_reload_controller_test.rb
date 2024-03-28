# frozen_string_literal: true

require 'test_helper'

class AdminReloadControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get admin_reload_index_url
    assert_response :success
  end
end
