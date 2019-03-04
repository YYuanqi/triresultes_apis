class Event
  include Mongoid::Document
  field :o, as: :order, type: Integer
  field :n, as: :name, type: String
  field :d, as: :distance, type: Float
  field :u, as: :units, type: String
  
  embedded_in :parent, polymorphic: :true, touch: true
  
  validates :order, presence: true
  validates :name, presence: true
  
  
  def meters
    units = self.units
    distance = self.distance
    if units == 'meters'
      distance
    elsif units == 'miles'
      distance * 1609.344
    elsif units == 'kilometers'
      distance * 1000
    elsif units == 'yards'
      distance * 0.9144
    end
  end
  
  def miles
    units = self.units
    distance = self.distance
    if units == 'miles'
      distance
    elsif units == 'meters'
      distance * 0.000621371
    elsif units == 'kilometers'
      distance * 0.621371
    elsif units == 'yards'
      distance * 0.000568182
    end
  end
end
