Hanami::Model.migration do
  change do
    create_table :etablissements do
      primary_key :id

      column :nom, String, null: false
      column :secteur, :secteur, null: false
      foreign_key :adresse_id, :adresses, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
