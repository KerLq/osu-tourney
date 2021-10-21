require "test_helper"

class TourneysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tourney = tourneys(:one)
  end

  test "should get index" do
    get tourneys_url
    assert_response :success
  end

  test "should get new" do
    get new_tourney_url
    assert_response :success
  end

  test "should create tourney" do
    assert_difference('Tourney.count') do
      post tourneys_url, params: { tourney: { spreadsheet: @tourney.spreadsheet, title: @tourney.title } }
    end

    assert_redirected_to tourney_url(Tourney.last)
  end

  test "should show tourney" do
    get tourney_url(@tourney)
    assert_response :success
  end

  test "should get edit" do
    get edit_tourney_url(@tourney)
    assert_response :success
  end

  test "should update tourney" do
    patch tourney_url(@tourney), params: { tourney: { spreadsheet: @tourney.spreadsheet, title: @tourney.title } }
    assert_redirected_to tourney_url(@tourney)
  end

  test "should destroy tourney" do
    assert_difference('Tourney.count', -1) do
      delete tourney_url(@tourney)
    end

    assert_redirected_to tourneys_url
  end
end
