# require 'Kconv'
class ItemsController < ApplicationController
before_action :set_item, only:[:edit, :update]

  def index
    @items = Item.limit(10).order('id DESC')
  end

  def new
    unless user_signed_in?
      redirect_to  new_user_session_path
    end
    @item = Item.new
    @item.images.build
    @item.categories.build
  end

  def create 
    @item = Item.new(item_params)
    render :new unless @item.save
  end

  def show
    @item = Item.find(params[:id])
    @image = Image.find_by(item_id: @item.id)
    @category = Category.find_by(item_id: @item.id)
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else 
      redirect_to edit_item_path(@item.id) 
    end
  end

  def destroy
    item = Item.find(params[:id])
    if item.destroy
      redirect_to root_path
    else
      redirect_to edit_item_path(@item.id) 
    end
  end

  private
  
  def item_params 
    params.require(:item).permit(:name, :explain, :state, :postage, :shipping_area, :shipping_date, :price, :brand, :size, :delivery_way, images_attributes: [:id, :image, :item_id], categories_attributes: [:id, :name, :item_id]).merge(user_id: current_user.id)
  end
  
  def set_item
    @item = Item.find(params[:id])
  end
end
