class ItemsController < ApplicationController

  before_action :find_item,      only: [:show, :edit, :update, :destroy, :upvote ]
  #before_action :check_if_admin, only: [:edit, :update, :new, :create, :destroy ]

  def index
    @items = Item.all
  end

  def show
   #if @item = Item.where(id: params[:id]).first
    unless @item
     #else
      render text: "Page not found.", status: 404
    end
  end

  def new
    @item = Item.new
  end

  def edit
    #@item = Item.find(params[:id])
    #@item = Item.where(id: params[:id]).first
  end

  # def create
  #  #@item = Item.create(params[:item])
  #   @item = Item.create(item_params)
  #   if @item.errors.empty?
  #
  #     redirect_to item_path(@item)
  #
  #   else
  #    render "new"
  # end
  #end


  def create
    item_params = params.require(:item).permit(:price, :name, :real, :weight, :description)
    @item = Item.create(item_params)
    if @item.errors.empty?
      redirect_to item_path(@item)
    else
      render "new"
    end
  end

  def update
    #@item = Item.find(params[:id])
    #@item = Item.where(id: params[:id]).first
    params.permit!
    if @item.errors.empty?
      @item.update_attributes(params[:item])
      redirect_to item_path(@item)
    else
      render "edit"
    end
  end

  def destroy
    #@item = Item.find(params[:id])
    #@item = Item.where(id: params[:id]).first
    @item.destroy
    redirect_to action: "index"

  end

  def upvote
    @item.increment!(:votes_count)
    redirect_to action: :index
  end

  def expensive
    @items = Item.where("price > 1000")
    render action: :index
  end

  private
  def find_item
   # @item = Item.find(params[:id])
    @item = Item.where(id: params[:id]).first
  end

  #def check_if_admin
   # render text: "Access denied.", status: 403 unless params[:admin]
  #end
end

