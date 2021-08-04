Hanami::Model.migration do
  change do
    extension :pg_enum
    create_enum :langue, %w[allemand anglais espagnol autre italien]
  end
end
