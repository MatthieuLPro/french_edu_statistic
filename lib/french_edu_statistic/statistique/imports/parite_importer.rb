module FrenchEduStatistic
  module Statistique
    module Imports
      class PariteImporter
        # Data format :
        # {
        #   annee: String, # 2020
        #   region_academique: String, # BRETAGNE
        #   academie: String, # RENNES
        #   departement: String, # MORBIHAN
        #   commune: String, # HENNEBONT
        #   college_nom: String, # PIERRE ET MARIE CURIE
        #   secteur: String, # PUBLIC
        #   nb_fille_6eme: String, # 82
        #   nb_garcon_6eme: String, # 92
        #   nb_fille_5eme: String, # 77
        #   nb_garcon_5eme: String, # 81
        #   nb_fille_4eme: String, # 73
        #   nb_garcon_4eme: String, # 92
        #   nb_fille_3eme: String, # 78
        #   nb_garcon_3eme: String, # 89
        # }

        def initialize(
          niveaux: Niveau::COLLECTION,
          adresse_repo: AdresseRepository.new,
          annee_repo: AnneeRepository.new,
          etablissement_repo: EtablissementRepository.new
        )
          @niveaux = niveaux
          @adresse_repo = adresse_repo
          @annee_repo = annee_repo
          @etablissement_repo = etablissement_repo
        end

        def from_csv(data)
          repository = StatistiquePariteRepository.new

          data.each do |row|
            entity = generate_parite_statistique(row)
            @niveaux.each_value do |niveau|
              repository.create(
                etablissement_id: entity.etablissement.id,
                niveau: niveau,
                nombre_fille: entity[niveau].nombre_fille,
                nombre_garcon: entity[niveau].nombre_garcon
              )
            end
          end
        end

        private

        def generate_parite_statistique(row)
          extractor = FrenchEduStatistic::Statistique::Imports::ResourceExtractor.new

          extractor.extract_adresse(row)
          extractor.extract_annee(row)
          extractor.extract_etablissement(row)

          current_adresse = @adresse_repo.find_or_create(extractor.adresse_information)
          current_annee = @annee_repo.find_or_create(extractor.annee_information)

          etablissement_information = extractor.etablissement_information
          etablissement_information.adresse_id = current_adresse.id
          current_etablissement = @etablissement_repo.find_or_create(etablissement_information)

          parite_entity = OpenStruct.new(
            adresse: current_adresse,
            annee: current_annee,
            etablissement: current_etablissement
          )
          parite_entity[Niveau::COLLECTION[:sixieme]] =
            OpenStruct.new(nombre_fille: row['nb_fille_6eme'], nombre_garcon: row['nb_garcon_6eme'])
          parite_entity[Niveau::COLLECTION[:cinquieme]] =
            OpenStruct.new(nombre_fille: row['nb_fille_5eme'], nombre_garcon: row['nb_garcon_5eme'])
          parite_entity[Niveau::COLLECTION[:quatrieme]] =
            OpenStruct.new(nombre_fille: row['nb_fille_4eme'], nombre_garcon: row['nb_garcon_4eme'])
          parite_entity[Niveau::COLLECTION[:troisieme]] =
            OpenStruct.new(nombre_fille: row['nb_fille_3eme'], nombre_garcon: row['nb_garcon_3eme'])
          parite_entity
        end
      end
    end
  end
end
