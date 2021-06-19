Hanami::Model.migration do
  change do
    create_table :statistique_parites do
      primary_key :id

      foreign_key :etablissement_id, :etablissements, null: false
      column :niveau, :niveau, null: false
      column :categorie, :categorie, null: false
      column :nombre_fille, :integer, null: false, default: 0
      column :nombre_garcon, :integer, null: false, default: 0

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
