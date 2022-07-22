require "application_system_test_case"

class ParisTest < ApplicationSystemTestCase
  setup do
    @pari = paris(:one)
  end

  test "visiting the index" do
    visit paris_url
    assert_selector "h1", text: "Paris"
  end

  test "should create pari" do
    visit paris_url
    click_on "New pari"

    fill_in "Cote", with: @pari.cote
    fill_in "Montant", with: @pari.montant
    check "Resultat" if @pari.resultat
    fill_in "Solde", with: @pari.solde
    fill_in "Type", with: @pari.type
    click_on "Create Pari"

    assert_text "Pari was successfully created"
    click_on "Back"
  end

  test "should update Pari" do
    visit pari_url(@pari)
    click_on "Edit this pari", match: :first

    fill_in "Cote", with: @pari.cote
    fill_in "Montant", with: @pari.montant
    check "Resultat" if @pari.resultat
    fill_in "Solde", with: @pari.solde
    fill_in "Type", with: @pari.type
    click_on "Update Pari"

    assert_text "Pari was successfully updated"
    click_on "Back"
  end

  test "should destroy Pari" do
    visit pari_url(@pari)
    click_on "Destroy this pari", match: :first

    assert_text "Pari was successfully destroyed"
  end
end
