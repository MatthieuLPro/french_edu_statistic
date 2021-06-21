class AnneeRepository < Hanami::Repository
  def find_by(value:)
    annees.where(value: value).one
  end

  def find_or_create(annee)
    find_by(value: annee.value) || create(annee)
  end
end
