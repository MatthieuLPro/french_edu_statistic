Hanami::Model.migration do
  change do
    extension :pg_enum
    create_enum :categorie,
                %w[lv1_allemand lv1_anglais lv1_espagnol lv1_autre lv2_allemand lv2_anglais lv2_espagnol lv2_italien
                   lv2_autre]
    create_enum :niveau, %w[3eme 4eme 5eme 6eme]
  end
end
