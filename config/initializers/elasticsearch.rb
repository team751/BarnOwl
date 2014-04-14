require 'elasticsearch/model'
require 'elasticsearch/transport'

if Rails.env.production?
  Elasticsearch::Client.new host: ENV['SEARCHBOX_URL']
  Item.__elasticsearch__.client = Elasticsearch::Client.new host: ENV['SEARCHBOX_URL']
  Drawer.__elasticsearch__.client = Elasticsearch::Client.new host: ENV['SEARCHBOX_URL']
  # Elasticsearch::Model.client = Elasticsearch::Client.new url: "http://paas:104cd4f8914496912532b33476089450@dwalin-us-east-1.searchly.com"
end