Hanami::Model.migration do
  change do
    create_table :annee_scolaires do
      primary_key :id

      foreign_key :etablissement_id, :etablissements, null: false
      foreign_key :annee_id, :annees, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
