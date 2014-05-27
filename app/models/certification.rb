class Certification
  include Mongoid::Document
  field :tool_name, type: String

  has_and_belongs_to_many :users  
end
