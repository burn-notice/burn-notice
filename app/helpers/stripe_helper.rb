module StripeHelper

  Expense = Struct.new(:amount, :currency, :service, :url, :provider)

  def expenses
    [
      Expense.new(400, 'eur', 'domain- and name-services',  'https://www.df.eu/', 'DomainFactory'),
      Expense.new(900, 'eur', 'PaaS provider', 'https://www.heroku.com/', 'Heroku'),
      Expense.new(2000, 'eur', 'SSL termination', 'https://www.cloudflare.com/', 'CloudFlare'),
    ]
  end

  def stripe_price(item)
    c = {
      'eur' => '€',
      'usd' => '$',
    }[item.currency.downcase]
    c ||= item.currency
    "#{c} #{item.amount / 100}".html_safe
  end

  def stripe_date(item)
    d(Time.at(item.created))
  end

  def plan_details(plan)
    "#{plan.amount}/#{plan.interval} #{plan.name} (#{plan.id})".html_safe
  end

  def user_plan(customer = nil)
    customer ||= Stripe::Customer.retrieve(current_user.stripe_customer_token)
    customer.try(:subscriptions).try(:data).try(:first).try(:plan)
  end

  def recent_transactions(transactions = nil)
    transactions ||= Stripe::BalanceTransaction.all(available_on: {gt: 1.month.ago.to_i}, type: :charge, limit: 100)
    transactions
  end
end
