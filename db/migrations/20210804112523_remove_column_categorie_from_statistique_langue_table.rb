Hanami::Model.migration do
  change do
    drop_column :statistique_langues, :categorie
  end
end
