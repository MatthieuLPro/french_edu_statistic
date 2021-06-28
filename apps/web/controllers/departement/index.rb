module Web
  module Controllers
    module Departement
      class Index
        include Web::Action

        def call(_params)
          self.status = 200
          self.body = serialize(fetch_adresses).to_json
          headers.merge!({ 'X-Custom' => 'OK' })
        end

        private

        def fetch_adresses
          AdresseRepository.new.all.sort_by(&:departement)
        end

        def serialize(adresses)
          Hash[adresses.collect.with_index { |adresse, _index| [adresse.departement, adresse.departement] }]
        end
      end
    end
  end
end
