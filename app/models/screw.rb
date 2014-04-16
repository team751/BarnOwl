class Screw
  include Mongoid::Document

  field :length, type: String
  field :size, type: String
  field :threading, type: String
  field :head, type: String
  
  validates_presence_of :size
  validates_presence_of :length
  
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
end
