require "application_system_test_case"

class ReglementsTest < ApplicationSystemTestCase
  setup do
    @reglement = reglements(:one)
  end

  test "visiting the index" do
    visit reglements_url
    assert_selector "h1", text: "Reglements"
  end

  test "should create reglement" do
    visit reglements_url
    click_on "New reglement"

    fill_in "Description", with: @reglement.description
    fill_in "Numero", with: @reglement.numero
    fill_in "Penalite", with: @reglement.penalite
    fill_in "Titre", with: @reglement.titre
    fill_in "Version", with: @reglement.version
    click_on "Create Reglement"

    assert_text "Reglement was successfully created"
    click_on "Back"
  end

  test "should update Reglement" do
    visit reglement_url(@reglement)
    click_on "Edit this reglement", match: :first

    fill_in "Description", with: @reglement.description
    fill_in "Numero", with: @reglement.numero
    fill_in "Penalite", with: @reglement.penalite
    fill_in "Titre", with: @reglement.titre
    fill_in "Version", with: @reglement.version
    click_on "Update Reglement"

    assert_text "Reglement was successfully updated"
    click_on "Back"
  end

  test "should destroy Reglement" do
    visit reglement_url(@reglement)
    click_on "Destroy this reglement", match: :first

    assert_text "Reglement was successfully destroyed"
  end
end
