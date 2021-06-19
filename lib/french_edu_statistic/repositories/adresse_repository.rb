class AdresseRepository < Hanami::Repository
  def find_by(region_academique:, academie:, departement:, commune:)
    adresses.where(
      region_academique: region_academique,
      academie: academie,
      departement: departement,
      commune: commune
    ).one
  end
end
