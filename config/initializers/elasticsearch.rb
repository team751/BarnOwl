require 'elasticsearch/model'
require 'elasticsearch/transport'

if Rails.env.production?

  # Elasticsearch::Model.client = Elasticsearch::Client.new url: "http://paas:104cd4f8914496912532b33476089450@dwalin-us-east-1.searchly.com"
end