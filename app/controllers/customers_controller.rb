class CustomersController < ApplicationController

  before_action :authenticate_customer!


  def show
    @customer = Customer.find(params[:id])
    @items = @customer.items.page(params[:page]).per(3)
  end

  def edit
    @customer = Customer.find(params[:id])
    if @customer == current_customer
      render "edit"
    else
      redirect_to customer_path(current_customer.id)
    end
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to customer_path(@customer.id)
  end

  def ensure_correct_user
   @customer = Customer.find(params[:id])
    unless @customer == current_customer
    redirect_to items_path
    end
  end


private

  def customer_params
    params.require(:customer).permit(:name, :profile_image,:introduction)
  end

end
