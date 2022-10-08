require "application_system_test_case"

class RapportdoisTest < ApplicationSystemTestCase
  setup do
    @rapportdoi = rapportdois(:one)
  end

  test "visiting the index" do
    visit rapportdois_url
    assert_selector "h1", text: "Rapportdois"
  end

  test "should create rapportdoi" do
    visit rapportdois_url
    click_on "New rapportdoi"

    fill_in "Commentaire", with: @rapportdoi.commentaire
    fill_in "Event", with: @rapportdoi.event_id
    fill_in "Penalitelicence", with: @rapportdoi.penalitelicence
    fill_in "Penalitetemps", with: @rapportdoi.penalitetemps
    fill_in "Pilote2", with: @rapportdoi.pilote2
    fill_in "Pilote", with: @rapportdoi.pilote_id
    fill_in "Reglement", with: @rapportdoi.reglement_id
    fill_in "Responsable", with: @rapportdoi.responsable
    click_on "Create Rapportdoi"

    assert_text "Rapportdoi was successfully created"
    click_on "Back"
  end

  test "should update Rapportdoi" do
    visit rapportdoi_url(@rapportdoi)
    click_on "Edit this rapportdoi", match: :first

    fill_in "Commentaire", with: @rapportdoi.commentaire
    fill_in "Event", with: @rapportdoi.event_id
    fill_in "Penalitelicence", with: @rapportdoi.penalitelicence
    fill_in "Penalitetemps", with: @rapportdoi.penalitetemps
    fill_in "Pilote2", with: @rapportdoi.pilote2
    fill_in "Pilote", with: @rapportdoi.pilote_id
    fill_in "Reglement", with: @rapportdoi.reglement_id
    fill_in "Responsable", with: @rapportdoi.responsable
    click_on "Update Rapportdoi"

    assert_text "Rapportdoi was successfully updated"
    click_on "Back"
  end

  test "should destroy Rapportdoi" do
    visit rapportdoi_url(@rapportdoi)
    click_on "Destroy this rapportdoi", match: :first

    assert_text "Rapportdoi was successfully destroyed"
  end
end
