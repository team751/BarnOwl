class Item
  include Mongoid::Document
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  
  field :name, type: String
  field :price, type: Float
  field :category_id, type: Integer
  field :barcode, type: String
  
  validates_presence_of :name
  
  has_and_belongs_to_many :drawers
  
  def as_indexed_json(options={})
    as_json(except: [:id, :_id])
  end
  
  def locations
    loc = []
    drawers.each do |drawer|
      loc << [drawer.row, drawer.column]
    end
    return loc
  end
  
  def self.randomBarcode
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    string = (0...13).map { o[rand(o.length)] }.join
  end
end

Item.import