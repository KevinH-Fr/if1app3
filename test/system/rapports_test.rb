require "application_system_test_case"

class RapportsTest < ApplicationSystemTestCase
  setup do
    @rapport = rapports(:one)
  end

  test "visiting the index" do
    visit rapports_url
    assert_selector "h1", text: "Rapports"
  end

  test "should create rapport" do
    visit rapports_url
    click_on "New rapport"

    fill_in "Article", with: @rapport.article_id
    fill_in "Commentaire", with: @rapport.commentaire
    fill_in "Event", with: @rapport.event_id
    fill_in "Penalitelicence", with: @rapport.penalitelicence
    fill_in "Penalitetemps", with: @rapport.penalitetemps
    fill_in "Pilote1", with: @rapport.pilote1_id
    fill_in "Pilote2", with: @rapport.pilote2_id
    fill_in "Responsable", with: @rapport.responsable_id
    click_on "Create Rapport"

    assert_text "Rapport was successfully created"
    click_on "Back"
  end

  test "should update Rapport" do
    visit rapport_url(@rapport)
    click_on "Edit this rapport", match: :first

    fill_in "Article", with: @rapport.article_id
    fill_in "Commentaire", with: @rapport.commentaire
    fill_in "Event", with: @rapport.event_id
    fill_in "Penalitelicence", with: @rapport.penalitelicence
    fill_in "Penalitetemps", with: @rapport.penalitetemps
    fill_in "Pilote1", with: @rapport.pilote1_id
    fill_in "Pilote2", with: @rapport.pilote2_id
    fill_in "Responsable", with: @rapport.responsable_id
    click_on "Update Rapport"

    assert_text "Rapport was successfully updated"
    click_on "Back"
  end

  test "should destroy Rapport" do
    visit rapport_url(@rapport)
    click_on "Destroy this rapport", match: :first

    assert_text "Rapport was successfully destroyed"
  end
end
