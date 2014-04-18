class OrdersController < ApplicationController
	
  	def new
    	@order = Order.new
  	end

  	def show
  	end

	def create
	    @order = Order.new(order_params)
	    if @order.save
	    	User.all.each do |user|
				UserMailer.work_order(@order, user).deliver
			end
			flash[:success] = "Work Order Form Completed!"
			redirect_to root_path
	    else
	      render 'new'
	    end
	end

  	def edit
    	@order = Order.find(params[:id])
  	end

	def update
	end

	def index
		@orders = Order.all
	end

	private

    def order_params
    	params.require(:order).permit(:issue, :description, :time) if params[:order]
    end

end