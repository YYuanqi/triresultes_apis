module Api
	class RacersController < ApplicationController
		protect_from_forgery with: :null_session
		
		def index
			if !request.accept || request.accept == "*/*"
				render plain: "/api/racers"
			end
		end

		def show
			if !request.accept || request.accept == "*/*"
				render plain: "/api/racers/#{params[:id]}"
			end
		end

		def entries
			if !request.accept || request.accept == "*/*"
				render plain: "/api/racers/#{params[:racer_id]}/entries"
			end
		end

		def entry
			if !request.accept || request.accept == "*/*"
				render plain: "/api/racers/#{params[:racer_id]}/entries/#{params[:id]}"
			end
		end

		def create
			if !request.accept || request.accept == "*/*"
				render plain: :nothing, status: :ok
			else
			end
		end
	end
end
