class KittensController < ApplicationController
  class UsersController < ApplicationController
    before_action :find_user, except: [:index, :new, :create]

    def index
      @kittens = Kitten.all
    end

    def show
      @kitten = Kitten.find(params[:id])
    end

    def new
      @kitten = Kitten.new
    end

    def edit
      @kitten = Kitten.new
    end

    def create
      @kitten = Kitten.new(params[:user])
      if @kitten.save
        flash[:success] = "Kitten successfully created"
        redirect_to @kitten
      else
        flash[:error] = "Something went wrong"
        render 'new'
      end
    end

    def update
      if @kitten.update_attributes(params[:user])
        flash[:success] = "Kitten was successfully updated"
        redirect_to @kitten
      else
        flash[:error] = "Something went wrong"
        render 'edit'
      end
    end

    def destroy
      if @kitten.destroy
        flash[:success] = "Kitten was successfully deleted"
        redirect_to @kittens_path
      else
        flash[:error] = "Something went wrong"
        redirect_to @kittens_path
      end
    end

    private

      def find_kitten
        @kitten = Kitten.find(params[:id])
      end

  end

end
