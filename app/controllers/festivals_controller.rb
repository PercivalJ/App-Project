class FestivalsController < ApplicationController

	def index
		@festivals = Festival.all
	end

	def show
		@festivals = Festival.all
		@festival = Festival.find(params[:id])
	end

	def new
		@festival = Festival.new
	end

	def create
		@festival = Festival.new(festival_params)
		if @festival.save
			session[:festival_id] = @festival.id.to_s	
			redirect_to festivals_path
		else
			render :new
		end
	end

	def edit
		@festival = Festival.find(params[:id])
	end

	def update
		@festival = Festival.find(params[:id])
		if @festival.update_attributes(festival_params)
			redirect_to festivals_path
		else 
			render :edit		
		end
	end

	def destroy
		festival = Festival.find(params[:id])
		Comment.where({festival_id: festival.id }).destroy_all
		Festival.destroy
		redirect_to festivals_path
	end

	private

	def festival_params
		params.require(:festival).permit(:name, :date, :location, :info, :image)
	end
end

	