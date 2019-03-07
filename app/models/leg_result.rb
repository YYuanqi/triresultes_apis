class LegResult
  include Mongoid::Document
  field :secs, as: :secs,  type: Float
  
  embedded_in :entran
  embeds_one :event, as: :parent
  
  validates :event, presence: true
  
  def calc_ave
    #subclasses will calc event-specific ave
  end
  
  after_initialize do |doc|
    calc_ave
  end
  
  def secs= value
    self[:secs] = value
    calc_ave
  end
end