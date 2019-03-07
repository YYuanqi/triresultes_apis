class RunResult < LegResult
	field :mmile, as: :minute_mile, type: Float
	
	def calc_ave
		if event && secs
			self.minute_mile = (self.secs/60)/self.event.miles
		end
	end
end
