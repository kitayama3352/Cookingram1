class ItemsController < ApplicationController

  before_action :authenticate_customer!
  before_action :ensure_correct_user,only: [:edit,:update,:destory]

  def new
     @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.customer_id = current_customer.id

    if @item.save
      redirect_to items_path
    else
      render :new
    end

  end

  def index
    @items = Item.page(params[:page]).reverse_order
    @customers = Customer.all
    @search = Item.ransack(params[:q])
    @products = @search.result(distinct: true)

  end

  def show
    @item = Item.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to item_path(item.id)
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to items_path
  end

  def ensure_correct_user
    @item = Item.find(params[:id])
    unless @item.customer_id == current_customer.id
      redirect_to items_path
    end
  end



private

  def item_params
    params.require(:item).permit(:name, :image, :caption)
  end

end
