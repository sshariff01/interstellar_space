class Gateway

  def initialize
    @gateway = Braintree::Gateway.new(
      :environment => :sandbox,
      :merchant_id => '49brpw5fx2dpjr8z',
      :public_key => 'bvqyvf6gkjsx8j3y',
      :private_key => '5f002d2e036ec995475485b1f9e5b1eb',
    )
  end

  def client_token
    @gateway.client_token.generate
  end

  def sale(amount, payment_method_nonce)
    @gateway.transaction.sale(
      :amount => amount,
      :payment_method_nonce => payment_method_nonce,
      :options => {
          :submit_for_settlement => true
      }
    )
  end

end

