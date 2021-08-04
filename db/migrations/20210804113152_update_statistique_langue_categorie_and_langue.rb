Hanami::Model.migration do
  change do
    add_column :statistique_langues, :categorie, :categorie, null: false
    add_column :statistique_langues, :langue, :langue, null: false
  end
end
