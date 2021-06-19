Hanami::Model.migration do
  change do
    create_table :statistique_langues do
      primary_key :id

      foreign_key :etablissement_id, :etablissements, null: false
      column :niveau, :niveau, null: false
      column :categorie, :categorie, null: false
      column :nombre_eleve, :integer, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
