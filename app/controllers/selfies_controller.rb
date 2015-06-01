class SelfiesController < ApplicationController
	before_action :find_selfie, only: [:show, :edit, :update, :destroy]
	def index		
	end

def new
	@selfie = Selfie.new
	@client_token = Braintree::ClientToken.generate
end

def create
	@selfie = Selfie.new(selfie_params)

	if @selfie.save
		result = Braintree::Transaction.sale(
      :amount => "10.00",
      :payment_method_nonce => params[:payment_method_nonce]
    )
    if result.success?
      notice: "Payment was successful"
    else
      flash[:notice] = "Payment unsuccessful"
    end
		redirect_to root_path, notice:"Succesfully message submitted"
	else
		render 'new'
	end
end


private

def selfie_params
	params.require(:selfie).permit(:message, :email_custom)
end


def find_selfie
	@selfie = Selfie.find(params[:id])		
end

end
