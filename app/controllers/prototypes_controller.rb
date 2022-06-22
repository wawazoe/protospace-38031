class PrototypesController < ApplicationController
  before_action :authenticate_user!#, except: [:index]
  def new
    @prototype = Prototype.new
  end

  def index
    @prototype = Prototype.all

  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

    def show
      @prototype = Prototype.find(params[:id])
      @comment = Comment.new
      @comments = @prototype.comment.includes(:user)
    end

    def edit
      @prototype = Prototype.find(params[:id])
      unless user_signed_in?
        redirect_to action: :index
      end
    end

    def update
        prototype = Prototype.find(params[:id])
     if prototype.update(prototype_params)
        redirect_to root_path
     else
        render :edit
     end
    end

    def destroy
      prototype = Prototype.find(params[:id])
      prototype.destroy
      redirect_to root_path
    end

  private

  def prototype_params
    params.require(:prototype).permit(:name, :title, :catch_copy, :concept, :image, :id).merge(user_id: current_user.id)
  end
end
