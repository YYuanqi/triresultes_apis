module Api
	class RacesController < ApplicationController
		protect_from_forgery with: :null_session
		
		rescue_from Mongoid::Errors::DocumentNotFound do |exception|
			Rails.logger.debug exception
			
			if !request.accept || request.accept == "*/*"
				render plain: "woops: cannot find race[#{params[:id]}]", status: :not_found
			elsif  request.accept == "application/xml"
				render status: :not_found, template: "api/error_msg",
				locals: { msg: "woops: cannot find race[#{params[:id]}]" }
			else
				render status: :not_found, template: "api/not_found",
				locals: { msg: "woops: cannot find race[#{params[:id]}]" }
			end
		end
		
		rescue_from ActionView::MissingTemplate do |exception|
			Rails.logger.debug exception
			render plain: "woops: we do not support that content-type[#{request.accept}]",
						 status: :unsupported_media_type
		end

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
				render race
			end
		end

		def results
			if !request.accept || request.accept == "*/*"
				render plain: "/api/races/#{params[:race_id]}/results" 
			else
				@race = Race.find(params[:race_id])
				if stale?(:last_modified => @race.entrants.max(:updated_at))
					@entrants = @race.entrants
				end
			end
			
		end

		def result
			if !request.accept || request.accept == "*/*"
				render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
			else
				result = Race.find(params[:race_id]).entrants.find(params[:id])
				render :partial=>"result", :object=>result
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
		
		def show_result
			entrant =Race.find(params[:race_id]).entrants.find(params[:id])
			result = params[:result]
			if result
				if result[:swim]
					entrant.swim = entrant.race.race.swim
					entrant.swim_secs = result[:swim].to_f
				end
				if result[:t1]
					entrant.t1 = entrant.race.race.t1
					entrant.t1_secs = result[:t1].to_f
				end
				if result[:bike]
					entrant.bike = entrant.race.race.bike
					entrant.bike_secs = result[:bike].to_f
				end
				if result[:t2]
					entrant.t2 = entrant.race.race.t2
					entrant.t2_secs = result[:t2].to_f
				end
				if result[:run]
					entrant.run = entrant.race.race.run
					entrant.run_secs = result[:run].to_f
				end
			end
			entrant.save
			render nothing: true, status: :ok
		end

		private
			def race_params
				params.require(:race).permit(:name, :date)
			end
	end
end
