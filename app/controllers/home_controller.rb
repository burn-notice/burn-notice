class HomeController < ApplicationController
  def index
  end

  def faq
  end

  def pricing
  end

  def donation
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => 100,
      :description => 'Burn-Notice donation',
      :currency    => 'eur'
    )

    redirect_to pricing_path, notice: t('home.thx_for_your_donation')
  rescue Stripe::CardError => e
    redirect_to pricing_path, alert: e.message
  end
end
