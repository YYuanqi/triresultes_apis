class Point
	attr_accessor :longitude, :latitude
	
	def initialize(longitude, latitude)
		@longitude = longitude
		@latitude = latitude
	end
	
	def self.mongoize object
		case object
		when nil then nil
		when Hash then object
		when Point then {:type => "Point", :coordinates => [object.longitude, object.latitude]}
		end
	end
	
	def mongoize
		{:type => "Point", :coordinates => [@longitude, @latitude]}
	end
	
	def self.evolve object
		self.mongoize object
	end
	
	def self.demongoize object
		case object
		when nil then nil
		when Hash then Point.new(object[:coordinates][0], object[:coordinates][1])
		when Point then object
		end
	end
end