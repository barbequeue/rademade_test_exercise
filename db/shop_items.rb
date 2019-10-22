require 'active_record'
require 'json'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  host: 'localhost',
  username: 'rademade',
  password: '123123123',
  database: 'rademade'
)

require_relative 'schema'
require_relative 'models'

# JSON data to process
data_json = <<~JSON
{
   "url":"https://example.com/dress/435?color=041",
   "product_sku":"435",
   "product_name":"Sundry Fabian Dress",
   "article_sku":"435_041",
   "article_name":"NAVY",
   "price":"$148.00",
   "photos":[
      {
         "url":"https://example.com/images/435_1.jpg"
      },
      {
         "url":"https://example.com/images/435_2.jpg"
      },
      {
         "url":"https://example.com/images/435_3.jpg"
      }
   ],
   "sizes":[
      {
         "size_sku":"435_041_4",
         "name":"XS",
         "available":true
      },
      {
         "size_sku":"435_041_5",
         "name":"S",
         "available":true
      },
      {
         "size_sku":"435_041_6",
         "name":"M",
         "available":true
      },
      {
         "size_sku":"435_041_7",
         "name":"L",
         "available":false
      },
      {
         "size_sku":"435_041_8",
         "name":"XL",
         "available":false
      }
   ]
}
JSON
data = JSON.parse(data_json)

# Seed database with default sizes
SIZES = %w[XXS XS S M L XL XXL XS/P S/P M/P L/P XL/P].freeze
SIZES.each { |size| Size.create(name: size) }

# Processing data
product = Product.create(
  name: data['product_name'],
  sku: data['product_sku']
)

product_article = ProductArticle.create(
  product_id: product.id,
  name: data['article_name'],
  url: data['url'],
  sku: data['article_sku'],
  price: data['price']
)

data['photos'].each do |photo|
  ProductPhoto.create(
    product_article_id: product_article.id,
    url: photo['url']
  )
end

data['sizes'].each do |size|
  fetch_size = Size.find_by_name(size['name'])

  ProductSize.create(
    product_article_id: product_article.id,
    size_id: fetch_size.id,
    sku: size['sku'],
    available: size['available'] == 'true'
  )
end

# Adding custom product articles
ProductArticle.create(
  product_id: product.id,
  sku: '324_021'
)
ProductArticle.create(
  product_id: product.id,
  sku: '892_15'
)

# Adding two new articles to relation to existing article
ProductArticleRelation.create(
  product_article_id: product_article.id,
  related_product_article_id: 2
)
ProductArticleRelation.create(
  product_article_id: product_article.id,
  related_product_article_id: 3
)

puts
puts "Outputting created data:"
p product
p product_article
product_article.product_photos.each { |photo| p photo }
product_article.product_sizes.each { |size| p size }

puts
puts "Outputting related articles:"
product_article.related_product_articles.each { |article| p article }
