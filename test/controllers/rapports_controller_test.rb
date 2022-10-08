require "test_helper"

class RapportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rapport = rapports(:one)
  end

  test "should get index" do
    get rapports_url
    assert_response :success
  end

  test "should get new" do
    get new_rapport_url
    assert_response :success
  end

  test "should create rapport" do
    assert_difference("Rapport.count") do
      post rapports_url, params: { rapport: { article_id: @rapport.article_id, commentaire: @rapport.commentaire, event_id: @rapport.event_id, penalitelicence: @rapport.penalitelicence, penalitetemps: @rapport.penalitetemps, pilote1_id: @rapport.pilote1_id, pilote2_id: @rapport.pilote2_id, responsable_id: @rapport.responsable_id } }
    end

    assert_redirected_to rapport_url(Rapport.last)
  end

  test "should show rapport" do
    get rapport_url(@rapport)
    assert_response :success
  end

  test "should get edit" do
    get edit_rapport_url(@rapport)
    assert_response :success
  end

  test "should update rapport" do
    patch rapport_url(@rapport), params: { rapport: { article_id: @rapport.article_id, commentaire: @rapport.commentaire, event_id: @rapport.event_id, penalitelicence: @rapport.penalitelicence, penalitetemps: @rapport.penalitetemps, pilote1_id: @rapport.pilote1_id, pilote2_id: @rapport.pilote2_id, responsable_id: @rapport.responsable_id } }
    assert_redirected_to rapport_url(@rapport)
  end

  test "should destroy rapport" do
    assert_difference("Rapport.count", -1) do
      delete rapport_url(@rapport)
    end

    assert_redirected_to rapports_url
  end
end
