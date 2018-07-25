class ProductsController < ApplicationController
  protect_from_forgery prepend: true

  def purchase
    if request.get?
      @product = Product.find_by(pk: params[:id])
      @client_token = Gateway.new.client_token

      render 'purchase'
    elsif request.post?
      logger.info "Issuing sale for #{params[:product_name]}"

      result = Gateway.new.sale(params[:product_price], params[:payment_method_nonce])

      logger.info "Sale result: #{result}"

      redirect_to merchant_root_url and return
    end
  end

end
