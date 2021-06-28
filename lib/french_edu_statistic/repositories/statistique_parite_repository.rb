class StatistiquePariteRepository < Hanami::Repository
  associations do
    has_one :etablissement
  end
end
