require 'csv'
require 'pry'

namespace :parite_data do
  desc 'Import parite data from csv'
  task import: :environment do
    csv = CSV.read('public/resources/parite_data.csv', { headers: true, col_sep: ';' })
    FrenchEduStatistic::Statistique::Imports::PariteImporter.new.from_csv(csv)
    puts 'Parite data is imported.'
  end
end
