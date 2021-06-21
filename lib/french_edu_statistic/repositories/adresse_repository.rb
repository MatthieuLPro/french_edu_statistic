class AdresseRepository < Hanami::Repository
  def find_by(region_academique:, academie:, departement:, commune:)
    adresses.where(
      region_academique: region_academique,
      academie: academie,
      departement: departement,
      commune: commune
    ).one
  end

  def find_or_create(adresse)
    find_by(
      region_academique: adresse.region_academique,
      academie: adresse.academie,
      departement: adresse.departement,
      commune: adresse.commune
    ) || create(adresse)
  end
end
