class Part
  include Mongoid::Document
  field :state_store, type: String
  field :name, type: String
  field :suffix, type: String
  field :assembly_id, type: String
  
  belongs_to :assembly
  
  def state
    state_store
  end
  
  def state_name
    if state_store == Part.IDEAS
      "Ideas"
    elsif state_store == Part.DESIGN_IN_PROGRESS
      "Design in progress"
    elsif state_store == Part.WAITING_FOR_ASSEMBLY
      "Waiting for assembly"
    elsif state_store == Part.PARTS_ORDERED
      "Parts ordered"
    elsif state_store == Part.DONE
      "Done"
    end
  end
  
  def state_html
    "<span class=\"label #{state_button_class}\">#{state_name}</span>"
  end
  
  def state_button_class
    if state_store == Part.IDEAS
      "label-info"
    elsif state_store == Part.DESIGN_IN_PROGRESS
      "label-primary"
    elsif state_store == Part.WAITING_FOR_ASSEMBLY
      "label-warning"
    elsif state_store == Part.PARTS_ORDERED
      "label-warning"
    elsif state_store == Part.DONE
      "label-success"
    end
  end
  
  def self.last_part_id
    Part.last.part_id+1
  end
  
  def part_id
    Part.all.find_index(self)
  end
  
  def part_number
    "751-#{assembly.prefix}-#{part_id}"
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
