require 'csv'
require 'pry'

def find_or_create_adresse(information)
  repository = AdresseRepository.new
  repository.find_by(
    region_academique: information.region_academique,
    academie: information.academie,
    departement: information.departement,
    commune: information.commune
  ) || repository.create(
    region_academique: information.region_academique,
    academie: information.academie,
    departement: information.departement,
    commune: information.commune
  )
end

def find_or_create_annee(information)
  repository = AnneeRepository.new
  repository.find_by(
    value: information.value,
  ) || repository.create(
    value: information.value,
  )
end

def find_or_create_etablissement(information)
  repository = EtablissementRepository.new
  repository.find_by(
    nom: information.nom,
    secteur: information.secteur,
    adresse_id: information.adresse_id
  ) || repository.create(
    nom: information.nom,
    secteur: information.secteur,
    adresse_id: information.adresse_id
  )
end

def to_parite_entity(row)
  current_adresse = find_or_create_adresse(OpenStruct.new(
    region_academique: row['region_academique'],
    academie: row['academie'],
    departement: row['departement'],
    commune: row['commune']
  ))
  current_annee = find_or_create_annee(OpenStruct.new(
    value: row['annee']
  ))
  current_etablissement = find_or_create_etablissement(OpenStruct.new(
    nom: row['college_nom'] || 'Nom répertorier',
    secteur: Secteur::COLLECTION[row['secteur'].to_sym],
    adresse_id: current_adresse.id
  ))
  parite_entity = OpenStruct.new(
    adresse: current_adresse,
    annee: current_annee,
    etablissement: current_etablissement
  )
  parite_entity[Niveau::COLLECTION[:sixieme]] = OpenStruct.new(nombre_fille: row['nb_fille_6eme'], nombre_garcon: row['nb_garcon_6eme'])
  parite_entity[Niveau::COLLECTION[:cinquieme]] = OpenStruct.new(nombre_fille: row['nb_fille_5eme'], nombre_garcon: row['nb_garcon_5eme'])
  parite_entity[Niveau::COLLECTION[:quatrieme]] = OpenStruct.new(nombre_fille: row['nb_fille_4eme'], nombre_garcon: row['nb_garcon_4eme'])
  parite_entity[Niveau::COLLECTION[:troisieme]] = OpenStruct.new(nombre_fille: row['nb_fille_3eme'], nombre_garcon: row['nb_garcon_3eme'])
  parite_entity
end

namespace :parite_data  do 
  desc 'Import parite data from csv'
  task import: :environment do
    repository = StatistiquePariteRepository.new 
    CSV.read('public/resources/parite_data.csv', { headers: true, col_sep: ';' }).each do |row|
      entity = to_parite_entity(row)
      Niveau::COLLECTION.each_value do |niveau|
        repository.create(
          etablissement_id: entity.etablissement.id,
          niveau: niveau,
          nombre_fille: entity[niveau].nombre_fille,
          nombre_garcon: entity[niveau].nombre_garcon
        )
      end
    end
    puts "Parite data is imported."
  end
end