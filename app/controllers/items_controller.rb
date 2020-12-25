class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    if @item.order.present?
      redirect_to root_path
    else
      unless current_user.id == @item.user_id
        redirect_to root_path
      end
    end
  end

  def update
    if current_user.id == @item.user_id
      if @item.update(item_params)
        redirect_to item_path(@item.id)
      else
        render :edit
      end
    else
      render :index
    end
  end

  def destroy
    if current_user.id == @item.user_id
      if @item.destroy
        redirect_to root_path
      else
        render :show
      end
    else
      render :show
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :explanation, :category_id,
                                 :condition_id, :delivery_charge_id, :prefecture_id,
                                 :shipping_day_id, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
