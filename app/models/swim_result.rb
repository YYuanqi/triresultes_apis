class SwimResult < LegResult
	field :pace_100, as: :pace_100, type: Float
	
	def calc_ave
		if event.meters && self.secs
			self.pace_100 = self.secs/(self.event.meters/100)
		end
	end
end
