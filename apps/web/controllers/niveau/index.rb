module Web
  module Controllers
    module Niveau
      class Index
        include Web::Action

        def call(_params)
          self.status = 200
          self.body = serialize(fetch_niveaux).to_json
          headers.merge!({ 'X-Custom' => 'OK' })
        end

        private

        def fetch_niveaux
          ::Niveau::COLLECTION
        end

        def serialize(niveaux)
          Hash[niveaux.collect { |_key, value| [value, value] }]
        end
      end
    end
  end
end
