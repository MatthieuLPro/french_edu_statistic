module Web
  module Controllers
    module Home
      class Parite
        include Web::Action

        # expose :adresses, :annees, :nb_eleves

        def call(params)
          # @adresses = fetch_adresses
          # @annees = fetch_annees
          # @nb_eleves = fetch_nombre_fille_and_garcon(1, 'AIN')
        end

        # private

        # def fetch_adresses
        #   @_fetch_adresses ||= AdresseRepository.new.all.sort_by(&:departement)
        # end

        # def fetch_annees
        #   AnneeRepository.new.all
        # end

        # def fetch_nombre_fille_and_garcon(annee_id, departement)
        #   repository = EtablissementRepository.new
        #   {
        #     nombre_fille: repository.statistique_parites_for_girls(annee_id, departement),
        #     nombre_garcon: repository.statistique_parites_for_boys(annee_id, departement),
        #   }
        # end
      end
    end
  end
end
