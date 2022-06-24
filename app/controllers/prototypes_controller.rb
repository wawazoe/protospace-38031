class PrototypesController < ApplicationController
  before_action :set_prototype, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]

  def new
    @prototype = Prototype.new
  end

  def index
    @prototype = Prototype.includes(:user)

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
     # @prototype = Prototype.find(params[:id])
      @comment = Comment.new
      @comments = @prototype.comments.includes(:user)
      user = User.find(params[:id])
      @name = user.name
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
        redirect_to prototype_path(@prototype)
     else
        render :edit
     end
    end

    def destroy
      prototype = Prototype.find(params[:id])
    if  prototype.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def prototype_params
    params.require(:prototype).permit( :title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def contributor_confirmation
    redirect_to root_path unless current_user == @prototype.user
  end
end
