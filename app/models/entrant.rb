class Entrant
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :bib, as: :bib, type: Integer
  field :secs,  as: :sec, type: Float
  field :o, as: :overall, type: Placing
  field :gender, as: :gender,  type: Placing
  field :group, as: :group, type: Placing
  
  delegate :first_name, :first_name=, to: :racer
  delegate :last_name, :last_name=, to: :racer
  delegate :gender, :gender=, to: :racer, prefix: "racer"
  delegate :birth_year, :birth_year=, to: :racer
  delegate :city, :city=, to: :racer
  delegate :state, :state=, to: :racer
  
  delegate :name, :name=, to: :race, prefix: "race"
  delegate :date, :date=, to: :race, prefix: "race"
  
  store_in collection: 'results'
  
  embeds_many :results, class_name: 'LegResult', order: [:"event.o".asc], after_add: :update_total
  embeds_one :race, class_name: 'RaceRef', autobuild: true
  embeds_one :racer, as: :parent, class_name: 'RacerInfo', autobuild: true
  
  RESULTS = {"swim"=>SwimResult,
            "t1"=>LegResult,
            "bike"=>BikeResult,
            "t2"=>LegResult,
            "run"=>RunResult}
            
  RESULTS.keys.each do |name|
    define_method("#{name}") do
      result=results.select {|result| name==result.event.name if result.event}.first
      if !result
        result=RESULTS["#{name}"].new(:event=>{:name=>name})
        results << result
      end
      result
    end

    define_method("#{name}=") do |event|
      event=self.send("#{name}").build_event(event.attributes)
    end
    
    RESULTS["#{name}"].attribute_names.reject {|r|/^_/===r}.each do |prop|
      define_method("#{name}_#{prop}") do
        event=self.send(name).send(prop)
      end
      define_method("#{name}_#{prop}=") do |value|
        event=self.send(name).send("#{prop}=",value)
        update_total nil if /secs/===prop
      end
    end
  end
  
  def update_total(result)
    secs = 0
    self.results.each do |r|
      if !r.secs.nil?
        secs += r.secs
      end
    end
    self.secs = secs
  end
  
  def the_race
    race.race
  end
  
  def overall_place
    overall.place if overall
  end
  def gender_place
    gender.place if gender
  end
  def group_name
    group.name if group
  end
  def group_place
    group.place if group
  end
end
