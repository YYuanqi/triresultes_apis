class Placing
	attr_accessor :name, :place
	
	def initialize(name, place)
		@name = name
		@place = place
	end
	
	def mongoize
		{:name => name, :place => @place}
	end
	
	def self.mongoize object
		case object
		when nil then nil
		when Hash then object
		when Placing then {:name=>object.name, :place=>object.place}
		end
	end
	
	def self.evolve object
		self.mongoize object
	end
	
	def self.demongoize object
		case object
		when nil then nil
		when Hash then self.new(object[:name], object[:place])
		when Placing then object
		end
	end
end