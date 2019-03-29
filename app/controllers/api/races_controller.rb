module Api
	class RacesController < ApplicationController
		protect_from_forgery with: :null_session

		def index
			if !request.accept || request.accept == "*/*"
				render plain: "/api/races, offset=[#{params[:offset]}], limit=[#{params[:limit]}]"
			end
		end

		def show
			if !request.accept || request.accept == "*/*"
				render plain: "/api/races/#{params[:id]}"
			end
		end

		def results
			if !request.accept || request.accept == "*/*"
				render plain: "/api/races/#{params[:race_id]}/results" 
			end
		end

		def result
			if !request.accept || request.accept == "*/*"
				render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
			end
		end
		def create
			if !request.accept || request.accept == "*/*"
				render plain: "#{params[:race][:name]}", status: :ok
			end
		end
	end
end
