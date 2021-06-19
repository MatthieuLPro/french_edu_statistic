class EtablissementRepository < Hanami::Repository
  def find_by(nom:, secteur:, adresse_id:)
    etablissements.where(
      nom: nom,
      secteur: secteur,
      adresse_id: adresse_id
    ).one
  end
end
