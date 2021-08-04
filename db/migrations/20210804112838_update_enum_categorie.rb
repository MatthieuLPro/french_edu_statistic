Hanami::Model.migration do
  change do
    extension :pg_enum
    drop_enum :categorie
    create_enum :categorie, %w[lv1 lv2]
  end
end
