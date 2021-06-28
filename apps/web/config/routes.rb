# Configure your routes here
# See: https://guides.hanamirb.org/routing/overview
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
root to: 'home#parite'

get '/annees', to: 'annee#index'
get '/departements', to: 'departement#index'

namespace 'statistique' do
  post 'parite', to: 'statistique#parite'
end