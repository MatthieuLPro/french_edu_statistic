module Web
  module Controllers
    module Statistique
      class Parite
        include Web::Action

        params do
          required(:annee_id).filled
          required(:departement).filled
          required(:niveau).filled
        end

        def call(params)
          self.status = 200
          self.body = fetch_nombre_fille_and_garcon(params[:annee_id], params[:departement], params[:niveau]).to_json
          headers.merge!({ 'X-Custom' => 'OK' })
        end

        private

        def fetch_nombre_fille_and_garcon(annee_id, departement, niveau)
          repository = EtablissementRepository.new
          {
            nombre_fille: repository.statistique_parites_for_girls(annee_id, departement, niveau),
            nombre_garcon: repository.statistique_parites_for_boys(annee_id, departement, niveau)
          }
        end
      end
    end
  end
end
