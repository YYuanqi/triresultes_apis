class Entrant
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :bib, as: :bib, type: Integer
  field :secs,  as: :sec, type: Float
  field :o, as: :overall, type: Placing
  field :gender, as: :gender,  type: Placing
  field :group, as: :group, type: Placing
  
  store_in collection: 'results'
  
  embeds_many :results, class_name: 'LegResult', order: [:"event.o".asc], after_add: :update_total
  embeds_one :race, class_name: 'RaceRef'
  embeds_one :racer, as: :parent, class_name: 'RacerInfo'
  
  def update_total(result)
    secs = 0
    self.results.each do |r|
      secs += r.secs
    end
    self.secs = secs
  end
  
  def the_race
    race.race
  end
end
