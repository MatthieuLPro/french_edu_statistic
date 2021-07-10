module Statistique
  module Serializers
    class NombreFilleGarcon
      def initialize(data:)
        @data = data
      end

      def serialize_fille_garcon_all_levels
        sum_boyz_and_girlz(group_by_departement(create_entities(@data)))
      end

      private

      def create_entities(data)
        data.map do |datum|
          {
            departement: datum[:departement],
            nombre_fille: datum[:nombre_fille],
            nombre_garcon: datum[:nombre_garcon]
          }
        end
      end

      def group_by_departement(data)
        data.group_by { |datum| datum[:departement] }
      end

      def sum_boyz_and_girlz(data)
        data.transform_values do |datum|
          {
            nombre_fille: datum.sum { |datum| datum[:nombre_fille] },
            nombre_garcon: datum.sum { |datum| datum[:nombre_garcon] }
          }
        end
      end
    end
  end
end
