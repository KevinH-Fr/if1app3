require "test_helper"

class ReglementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reglement = reglements(:one)
  end

  test "should get index" do
    get reglements_url
    assert_response :success
  end

  test "should get new" do
    get new_reglement_url
    assert_response :success
  end

  test "should create reglement" do
    assert_difference("Reglement.count") do
      post reglements_url, params: { reglement: { description: @reglement.description, numero: @reglement.numero, penalite: @reglement.penalite, titre: @reglement.titre, version: @reglement.version } }
    end

    assert_redirected_to reglement_url(Reglement.last)
  end

  test "should show reglement" do
    get reglement_url(@reglement)
    assert_response :success
  end

  test "should get edit" do
    get edit_reglement_url(@reglement)
    assert_response :success
  end

  test "should update reglement" do
    patch reglement_url(@reglement), params: { reglement: { description: @reglement.description, numero: @reglement.numero, penalite: @reglement.penalite, titre: @reglement.titre, version: @reglement.version } }
    assert_redirected_to reglement_url(@reglement)
  end

  test "should destroy reglement" do
    assert_difference("Reglement.count", -1) do
      delete reglement_url(@reglement)
    end

    assert_redirected_to reglements_url
  end
end
