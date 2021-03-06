class BikeResult < LegResult
	field :mph, as: :mph, type: Float
	
	def calc_ave
		if event && secs
			self.mph = self.event.miles*3600/self.secs
		end
	end
end
