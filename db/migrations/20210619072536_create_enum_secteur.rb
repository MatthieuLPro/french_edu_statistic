Hanami::Model.migration do
  change do
    extension :pg_enum
    create_enum :secteur, %w(publique prive)
  end
end
