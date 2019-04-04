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
			else
				race = Race.find(params[:id])
				render json: race
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
			else
				Race.create(name: params[:race][:name], date: params[:race][:date])
				render plain: "#{params[:race][:name]}", status: :created
			end
		end

		def update
			race = Race.find(params[:id])
			race.update(race_params)
			render json: race
		end

		def delete
			race = Race.find(params[:id])
			race.destroy!
			render nothing: true, status: :no_content
		end

		private
			def race_params
				params.require(:race).permit(:name, :date)
			end
	end
end
