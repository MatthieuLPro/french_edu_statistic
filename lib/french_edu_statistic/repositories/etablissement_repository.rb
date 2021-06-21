class EtablissementRepository < Hanami::Repository
  def find_by(nom:, secteur:, adresse_id:)
    etablissements.where(
      nom: nom,
      secteur: secteur,
      adresse_id: adresse_id
    ).one
  end

  def find_or_create(etablissement)
    find_by(
      nom: etablissement.nom,
      secteur: etablissement.secteur,
      adresse_id: etablissement.adresse_id
    ) || create(etablissement)
  end
end
