class Address
	attr_accessor :city, :state, :location
	
	def initialize(city = nil , state = nil, location = nil)
		@city = city
		@state = state
		@location = Point.demongoize(location)
	end
	
	def self.mongoize object
		case object
		when nil then nil
		when Hash then object
		when Address then {:city => object.city, :state => object.state, :loc => Point.mongoize(object.location)}
		end
	end
	
	def mongoize
		{:city => @city, :state => @state, :loc => Point.mongoize(@location)}
	end
	
	def self.evolve object
		self.mongoize object
	end
	
	def self.demongoize object
		case object
		when nil then nil
		when Hash then Address.new(object[:city], object[:state], object[:loc])
		when Point then object
		end
	end
end