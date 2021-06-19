class AnneeRepository < Hanami::Repository
  def find_by(value:)
    annees.where(value: value).one
  end
end
