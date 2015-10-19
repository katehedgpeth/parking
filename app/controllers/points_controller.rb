class PointsController < ApplicationController

  def index
    points = Point.where("lat > ?", 0)
    render json: points
  end

  def update
    if point.update(params)
      puts "successfully saved point #{params[:id]}"
      render json: point
    end
  end

  def point
    Point.find(params[:id])
  end

end
