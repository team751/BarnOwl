require 'elasticsearch/model'

if ENV['BONSAI_URL']
  Elasticsearch::Model.client = Elasticsearch::Client.new({url: ENV['BONSAI_URL'], logs: true})
  BONSAI_INDEX_NAME = ENV['BONSAI_URL'][/[^\/]+$/]
else
  Elasticsearch::Model.client = Elasticsearch::Client.new({url: "localhost:9200", logs: true})
  # app_name = Rails.application.class.parent_name.underscore.dasherize
  # BONSAI_INDEX_NAME = "#{app_name}-#{Rails.env}"
end