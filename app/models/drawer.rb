require 'elasticsearch/model'
require 'elasticsearch/model/callbacks'

class Drawer
  include Mongoid::Document
  # include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks
          
  field :section, type: Integer
  field :row, type: Integer
  field :column, type: Integer
  field :label, type: String
  
  validates_presence_of :row
  validates_presence_of :column
  validates_presence_of :label
  
  has_and_belongs_to_many :items
  has_and_belongs_to_many :screws
  
  validate :check_row_column
    
  def as_indexed_json(options={})
    as_json(except: [:id, :_id])
  end
  
  def check_row_column 
    if (Drawer.where(:row => row, :column => column)-[self]).count > 0
      errors[:base] << "Location cannot already be in use"
    end
  end
  
  def self.numberOfRows
    greatest = 0
    Drawer.all.each do |d|
      if d.row > greatest
        greatest = d.row
      end
    end
    
    greatest
  end
  
  def self.numberOfColumns
    greatest = 0
    Drawer.all.each do |d|
      if d.column > greatest
        greatest = d.column
      end
    end
    
    greatest
  end
end

# Drawer.import