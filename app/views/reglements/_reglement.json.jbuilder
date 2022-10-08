json.extract! reglement, :id, :version, :titre, :numero, :description, :penalite, :created_at, :updated_at
json.url reglement_url(reglement, format: :json)
