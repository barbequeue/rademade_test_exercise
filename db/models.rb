class Product < ActiveRecord::Base
  has_many :product_articles
end

class Size < ActiveRecord::Base
  has_many :product_sizes
end

class ProductArticle < ActiveRecord::Base
  belongs_to :product
  has_many :product_sizes
  has_many :product_photos

  has_many :product_article_relations
  has_many :related_product_articles, through: :product_article_relations, source: :related_product_article
end

class ProductSize < ActiveRecord::Base
  belongs_to :product_article
  belongs_to :size
end

class ProductPhoto < ActiveRecord::Base
  belongs_to :product_article
end

class ProductArticleRelation < ActiveRecord::Base
  belongs_to :product_article
  belongs_to :related_product_article, class_name: 'ProductArticle'
end
