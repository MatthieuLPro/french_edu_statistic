Hanami::Model.migration do
  change do
    create_table :adresses do
      primary_key :id

      column :region_academique, String, null: false
      column :academie, String, null: false
      column :departement, String, null: false
      column :commune, String, null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
