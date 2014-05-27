class Assembly
  include Mongoid::Document
  field :state_store, type: String
  field :name, type: String
  field :prefix, type: String
  field :year, type: Integer
  
  has_many :parts, dependent: :delete
  
  def state
    state_store
  end
  
  def state_name
    if state_store == Assembly.IDEAS
      "Ideas"
    elsif state_store == Assembly.DESIGN_IN_PROGRESS
      "Design in progress"
    elsif state_store == Assembly.WAITING_FOR_ASSEMBLY
      "Waiting for assembly"
    elsif state_store == Assembly.PARTS_ORDERED
      "Parts ordered"
    elsif state_store == Assembly.DONE
      "Done"
    end
  end
  
  def state_html
    "<span class=\"label #{state_button_class}\">#{state_name}</span>"
  end
  
  def state_button_class
    if state_store == Assembly.IDEAS
      "label-info"
    elsif state_store == Assembly.DESIGN_IN_PROGRESS
      "label-primary"
    elsif state_store == Assembly.WAITING_FOR_ASSEMBLY
      "label-warning"
    elsif state_store == Assembly.PARTS_ORDERED
      "label-warning"
    elsif state_store == Assembly.DONE
      "label-success"
    end
  end
  
  def self.IDEAS
    "ideas"
  end
  
  def self.DESIGN_IN_PROGRESS
    "design_in_progress"
  end
  
  def self.WAITING_FOR_ASSEMBLY
    "waiting_for_assembly"
  end
  
  def self.PARTS_ORDERED
    "parts_ordered"
  end
  
  def self.DONE
    "done"
  end
end
