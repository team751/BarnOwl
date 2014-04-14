require 'elasticsearch/model'
require 'elasticsearch/model/callbacks'

class Drawer
  include Mongoid::Document
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  
  field :section, type: Integer
  field :row, type: Integer
  field :column, type: Integer
  field :label, type: String
  
  has_and_belongs_to_many :items
    
  def as_indexed_json(options={})
    as_json(except: [:id, :_id])
  end
end

Drawer.import