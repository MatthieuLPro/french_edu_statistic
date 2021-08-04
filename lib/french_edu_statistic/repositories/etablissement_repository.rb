class EtablissementRepository < Hanami::Repository
  associations do
    belongs_to :adresse
    has_many :statistique_parites
  end

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

  def fetch_statistique_parites_by_niveau(annee_id, niveau)
    etablissements
      .join(:statistique_parites)
      .join(:adresse)
      .where(annee_id: annee_id, niveau: niveau)
      .select(
        adresses[:departement],
        statistique_parites[:nombre_fille],
        statistique_parites[:nombre_garcon]
      )
  end

  def fetch_statistique_parites_by(annee_id)
    etablissements
      .join(:statistique_parites)
      .join(:adresse)
      .where(annee_id: annee_id)
      .select(
        adresses[:departement],
        statistique_parites[:nombre_fille],
        statistique_parites[:nombre_garcon]
      )
  end
end
