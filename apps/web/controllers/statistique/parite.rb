module Web
  module Controllers
    module Statistique
      class Parite
        include Web::Action

        params do
          required(:annee_id).filled
          required(:niveau).filled
        end

        def call(params)
          self.status = 200
          self.body = fetch_nombre_fille_and_garcon(params[:annee_id], params[:niveau]).to_json
          headers.merge!({ 'X-Custom' => 'OK' })
        end

        private

        def fetch_nombre_fille_and_garcon(annee_id, niveau)
          repository = EtablissementRepository.new
          statistique_parites = if niveau == 'Tout'
            repository.fetch_statistique_parites_by(annee_id)
          else
            repository.fetch_statistique_parites_by_niveau(annee_id, niveau)
          end
          ::Statistique::Serializers::NombreFilleGarcon.new(data: statistique_parites).serialize_fille_garcon_all_levels
        end


      end
    end
  end
end
