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

  def statistique_parites_for_girls(annee_id, departement)
    with_statistique_parites(annee_id, departement).sum(statistique_parites[:nombre_fille])
  end

  def statistique_parites_for_boys(annee_id, departement)
    with_statistique_parites(annee_id, departement).sum(statistique_parites[:nombre_garcon])
  end

  private

  def with_statistique_parites(annee_id, departement)
    @_with_statistique_parites ||= aggregate(:adresse)
                                   .join(:adresse)
                                   .where(adresses[:departement].qualified => departement)
                                   .join(:statistique_parites)
                                   .where(statistique_parites[:annee_id].qualified => annee_id)
  end
end
