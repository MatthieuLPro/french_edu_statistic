module Web
  module Controllers
    module Annee
      class Index
        include Web::Action

        def call(_params)
          self.status = 200
          self.body = serialize(fetch_annees).to_json
          headers.merge!('X-Custom' => 'OK')
        end

        private

        def fetch_annees
          AnneeRepository.new.all
        end

        def serialize(annees)
          Hash[annees.collect { |annee| [annee.value, annee.id] }]
        end
      end
    end
  end
end
