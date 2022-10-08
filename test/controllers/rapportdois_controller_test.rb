require "test_helper"

class RapportdoisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rapportdoi = rapportdois(:one)
  end

  test "should get index" do
    get rapportdois_url
    assert_response :success
  end

  test "should get new" do
    get new_rapportdoi_url
    assert_response :success
  end

  test "should create rapportdoi" do
    assert_difference("Rapportdoi.count") do
      post rapportdois_url, params: { rapportdoi: { commentaire: @rapportdoi.commentaire, event_id: @rapportdoi.event_id, penalitelicence: @rapportdoi.penalitelicence, penalitetemps: @rapportdoi.penalitetemps, pilote2: @rapportdoi.pilote2, pilote_id: @rapportdoi.pilote_id, reglement_id: @rapportdoi.reglement_id, responsable: @rapportdoi.responsable } }
    end

    assert_redirected_to rapportdoi_url(Rapportdoi.last)
  end

  test "should show rapportdoi" do
    get rapportdoi_url(@rapportdoi)
    assert_response :success
  end

  test "should get edit" do
    get edit_rapportdoi_url(@rapportdoi)
    assert_response :success
  end

  test "should update rapportdoi" do
    patch rapportdoi_url(@rapportdoi), params: { rapportdoi: { commentaire: @rapportdoi.commentaire, event_id: @rapportdoi.event_id, penalitelicence: @rapportdoi.penalitelicence, penalitetemps: @rapportdoi.penalitetemps, pilote2: @rapportdoi.pilote2, pilote_id: @rapportdoi.pilote_id, reglement_id: @rapportdoi.reglement_id, responsable: @rapportdoi.responsable } }
    assert_redirected_to rapportdoi_url(@rapportdoi)
  end

  test "should destroy rapportdoi" do
    assert_difference("Rapportdoi.count", -1) do
      delete rapportdoi_url(@rapportdoi)
    end

    assert_redirected_to rapportdois_url
  end
end
