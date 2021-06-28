module Web
  module Views
    module Home
      class Parite
        include Web::View

        def annees_options
          Hash[annees.collect {|annee| [annee.value, annee.id] }]
        end

        def departements_options
          Hash[adresses.collect.with_index {|adresse, index| [adresse.departement, adresse.departement] }]
        end

        def pourcentage_fille
          nb_eleves[:nombre_fille].to_f / (nb_eleves[:nombre_fille] + nb_eleves[:nombre_garcon]).to_f * 100
        end

        def pourcentage_garcon
          nb_eleves[:nombre_garcon].to_f / (nb_eleves[:nombre_fille] + nb_eleves[:nombre_garcon]).to_f * 100
        end
      end
    end
  end
end