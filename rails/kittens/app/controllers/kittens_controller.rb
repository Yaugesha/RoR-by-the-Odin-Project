class KittensController < ApplicationController

  def index
    @kittens = Kitten.all
    respond_to do |format|
      format.json  { render json: @kittens }
    end
  end

  def show
    @kitten = Kitten.find(params[:id])
    respond_to do |format|
      format.json  { render json: @kitten }
    end
  end
end
