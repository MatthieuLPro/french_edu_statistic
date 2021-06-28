module Web
  module Controllers
    module Statistique
      class Parite
        include Web::Action

        def call(params)
          pp params[:params]
          self.status = 200
          self.body = 'Done'
          headers.merge!({ 'X-Custom' => 'OK' })
        end

        private

        def fetch_nombre_fille_and_garcon(annee_id, departement)
          repository = EtablissementRepository.new
          {
            nombre_fille: repository.statistique_parites_for_girls(annee_id, departement),
            nombre_garcon: repository.statistique_parites_for_boys(annee_id, departement)
          }
        end
      end
    end
  end
end
