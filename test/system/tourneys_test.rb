require "application_system_test_case"

class TourneysTest < ApplicationSystemTestCase
  setup do
    @tourney = tourneys(:one)
  end

  test "visiting the index" do
    visit tourneys_url
    assert_selector "h1", text: "Tourneys"
  end

  test "creating a Tourney" do
    visit tourneys_url
    click_on "New Tourney"

    fill_in "Spreadsheet", with: @tourney.spreadsheet
    fill_in "Title", with: @tourney.title
    click_on "Create Tourney"

    assert_text "Tourney was successfully created"
    click_on "Back"
  end

  test "updating a Tourney" do
    visit tourneys_url
    click_on "Edit", match: :first

    fill_in "Spreadsheet", with: @tourney.spreadsheet
    fill_in "Title", with: @tourney.title
    click_on "Update Tourney"

    assert_text "Tourney was successfully updated"
    click_on "Back"
  end

  test "destroying a Tourney" do
    visit tourneys_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tourney was successfully destroyed"
  end
end
