class Event
  include Mongoid::Document
  field :o, as: :order, type: Integer
  field :n, as: :name, type: Name
  field :d, as: :distance, type: Distance
  field :u, as: :units, type: Units
end
