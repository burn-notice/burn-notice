class ChargesController < ApplicationController
  before_action :authenticate!

  def index
  end

  def new
  end

  def create
    redirect_to charges_path, alert: t('charges.only_one_subscription') if current_user.stripe?

    options = {
      email: params[:stripeEmail],
      source: params[:stripeToken],
      plan: 'supporter',
      :description => 'Burn-Notice subscription',
    }
    customer = Stripe::Customer.create(options)
    current_user.update! stripe_customer_token: customer.id

    redirect_to charges_path, notice: t('charges.plan_subscribed')
  rescue Stripe::CardError => e
    redirect_to new_charge_path, alert: e.message
  end

  def destroy
    redirect_to charges_path, alert: t('charges.please_subscribe_first') unless current_user.stripe?

    customer = Stripe::Customer.retrieve(current_user.stripe_customer_token)
    customer.subscriptions.each { |subscription| subscription.delete }

    current_user.update! stripe_customer_token: nil

    redirect_to charges_path, notice: t('charges.plan_canceled')
  rescue Stripe::CardError => e
    redirect_to new_charge_path, alert: e.message
  end
end
