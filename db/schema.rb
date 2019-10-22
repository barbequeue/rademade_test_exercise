ActiveRecord::Schema.define do
  self.verbose = true

  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table(:products, force: true) do |t|
    t.string :name
    t.string :sku
    t.timestamps
  end

  create_table(:product_articles, force: true) do |t|
    t.belongs_to :product
    t.string :name
    t.string :url
    t.string :sku
    t.float :price
    t.timestamps
  end

  create_table(:sizes, force: true) do |t|
    t.string :name
    t.timestamps
  end

  create_table(:product_sizes, force: true) do |t|
    t.belongs_to :product_article
    t.belongs_to :size
    t.string :sku
    t.boolean :available
    t.timestamps
  end

  create_table(:product_photos, force: true) do |t|
    t.belongs_to :product_article
    t.string :url
    t.timestamps
  end

  # this table describes related articles
  create_table(:product_article_relations, force: true) do |t|
    t.belongs_to :product_article
    t.belongs_to :related_product_article
    t.timestamps
  end
end
