require "test_helper"

class ParisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pari = paris(:one)
  end

  test "should get index" do
    get paris_url
    assert_response :success
  end

  test "should get new" do
    get new_pari_url
    assert_response :success
  end

  test "should create pari" do
    assert_difference("Pari.count") do
      post paris_url, params: { pari: { cote: @pari.cote, montant: @pari.montant, resultat: @pari.resultat, solde: @pari.solde, type: @pari.type } }
    end

    assert_redirected_to pari_url(Pari.last)
  end

  test "should show pari" do
    get pari_url(@pari)
    assert_response :success
  end

  test "should get edit" do
    get edit_pari_url(@pari)
    assert_response :success
  end

  test "should update pari" do
    patch pari_url(@pari), params: { pari: { cote: @pari.cote, montant: @pari.montant, resultat: @pari.resultat, solde: @pari.solde, type: @pari.type } }
    assert_redirected_to pari_url(@pari)
  end

  test "should destroy pari" do
    assert_difference("Pari.count", -1) do
      delete pari_url(@pari)
    end

    assert_redirected_to paris_url
  end
end
