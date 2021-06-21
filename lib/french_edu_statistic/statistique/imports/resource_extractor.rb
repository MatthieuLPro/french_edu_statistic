module FrenchEduStatistic
  module Statistique
    module Imports
      class ResourceExtractor
        DEFAULT_NOM_ETABLISSEMENT = 'Nom répertorier'

        attr_reader :adresse_information, :annee_information, :etablissement_information

        def initialize(secteurs: Secteur::COLLECTION)
          @secteurs = secteurs
          @adresse_information = nil
          @annee_information = nil
          @etablissement_information = nil
        end

        def extract_adresse(row)
          @adresse_information = OpenStruct.new(
            region_academique: row['region_academique'],
            academie: row['academie'],
            departement: row['departement'],
            commune: row['commune']
          )
        end

        def extract_annee(row)
          @annee_information = OpenStruct.new(
            value: row['annee']
          )
        end

        def extract_etablissement(row)
          nom = row['college_nom'] || DEFAULT_NOM_ETABLISSEMENT
          secteur = @secteurs[row['secteur'].to_sym]

          @etablissement_information = OpenStruct.new(
            nom: nom,
            secteur: secteur
          )
        end
      end
    end
  end
end
