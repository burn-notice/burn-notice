require 'spec_helper'

describe StripeHelper do
  let(:plan) { Stripe::Plan.construct_from(JSON.parse(PLAN_JSON)) }
  let(:event) { Stripe::Event.construct_from(JSON.parse(EVENT_JSON)) }
  let(:events) { Stripe::ListObject.construct_from(JSON.parse(EVENT_LIST_JSON)) }
  let(:customer) { Stripe::Customer.construct_from(JSON.parse(CUSTOMER_JSON)) }

  it "displays plan information nicely" do
    expect(helper.plan_details(plan)).to eql("100/month Burn-Notice-Supporter (supporter)")
  end

  it "collects recent payments" do
    expect(recent_payments(events).first.plan.to_json).to eql(plan.to_json)
  end

  it "gets plan from customer" do
    expect(user_plan(customer).to_json).to eql(plan.to_json)
  end
end

EVENT_LIST_JSON = <<EVENT_LIST
{
  "object": "list",
  "url": "/v1/events",
  "has_more": false,
  "data": [
    {
      "id": "evt_17MPwr4Y9IeTYc8FsuNVN23A",
      "object": "event",
      "api_version": "2015-10-16",
      "created": 1451166697,
      "data": {
        "object": {
          "id": "sub_7bdDeyT1ckz4Fs",
          "object": "subscription",
          "application_fee_percent": null,
          "cancel_at_period_end": false,
          "canceled_at": null,
          "current_period_end": 1453845096,
          "current_period_start": 1451166696,
          "customer": "cus_7bdDXLpNtwdVCD",
          "discount": null,
          "ended_at": null,
          "metadata": {
          },
          "plan": {
            "id": "supporter",
            "object": "plan",
            "amount": 100,
            "created": 1451166160,
            "currency": "eur",
            "interval": "month",
            "interval_count": 1,
            "livemode": false,
            "metadata": {
            },
            "name": "Burn-Notice-Supporter",
            "statement_descriptor": null,
            "trial_period_days": null
          },
          "quantity": 1,
          "start": 1451166696,
          "status": "active",
          "tax_percent": null,
          "trial_end": null,
          "trial_start": null
        }
      },
      "livemode": false,
      "pending_webhooks": 0,
      "request": "req_7bdDyLfgk0lVvN",
      "type": "customer.subscription.created"
    }
  ]
}
EVENT_LIST

PLAN_JSON = <<PLAN
{
  "id": "supporter",
  "object": "plan",
  "amount": 100,
  "created": 1451166160,
  "currency": "eur",
  "interval": "month",
  "interval_count": 1,
  "livemode": false,
  "metadata": {
  },
  "name": "Burn-Notice-Supporter",
  "statement_descriptor": null,
  "trial_period_days": null
}
PLAN

CUSTOMER_JSON = <<CUSTOMER
{
  "id": "cus_7bdDXLpNtwdVCD",
  "object": "customer",
  "account_balance": 0,
  "created": 1451166696,
  "currency": "eur",
  "default_source": "card_17MPwm4Y9IeTYc8FzS90beKO",
  "delinquent": false,
  "description": null,
  "discount": null,
  "email": "phoetmail+stripe-test@googlemail.com",
  "livemode": false,
  "metadata": {
  },
  "shipping": null,
  "sources": {
    "object": "list",
    "data": [
      {
        "id": "card_17MPwm4Y9IeTYc8FzS90beKO",
        "object": "card",
        "address_city": null,
        "address_country": null,
        "address_line1": null,
        "address_line1_check": null,
        "address_line2": null,
        "address_state": null,
        "address_zip": null,
        "address_zip_check": null,
        "brand": "Visa",
        "country": "US",
        "customer": "cus_7bdDXLpNtwdVCD",
        "cvc_check": "pass",
        "dynamic_last4": null,
        "exp_month": 11,
        "exp_year": 2019,
        "funding": "credit",
        "last4": "4242",
        "metadata": {
        },
        "name": "phoetmail+stripe-test@googlemail.com",
        "tokenization_method": null
      }
    ],
    "has_more": false,
    "total_count": 1,
    "url": "/v1/customers/cus_7bdDXLpNtwdVCD/sources"
  },
  "subscriptions": {
    "object": "list",
    "data": [
      {
        "id": "sub_7bdDeyT1ckz4Fs",
        "object": "subscription",
        "application_fee_percent": null,
        "cancel_at_period_end": false,
        "canceled_at": null,
        "current_period_end": 1453845096,
        "current_period_start": 1451166696,
        "customer": "cus_7bdDXLpNtwdVCD",
        "discount": null,
        "ended_at": null,
        "metadata": {
        },
        "plan": {
          "id": "supporter",
          "object": "plan",
          "amount": 100,
          "created": 1451166160,
          "currency": "eur",
          "interval": "month",
          "interval_count": 1,
          "livemode": false,
          "metadata": {
          },
          "name": "Burn-Notice-Supporter",
          "statement_descriptor": null,
          "trial_period_days": null
        },
        "quantity": 1,
        "start": 1451166696,
        "status": "active",
        "tax_percent": null,
        "trial_end": null,
        "trial_start": null
      }
    ],
    "has_more": false,
    "total_count": 1,
    "url": "/v1/customers/cus_7bdDXLpNtwdVCD/subscriptions"
  }
}
CUSTOMER

EVENT_JSON = <<EVENT
{
  "id": "evt_17MPwr4Y9IeTYc8FsuNVN23A",
  "object": "event",
  "api_version": "2015-10-16",
  "created": 1451166697,
  "data": {
    "object": {
      "id": "sub_7bdDeyT1ckz4Fs",
      "object": "subscription",
      "application_fee_percent": null,
      "cancel_at_period_end": false,
      "canceled_at": null,
      "current_period_end": 1453845096,
      "current_period_start": 1451166696,
      "customer": "cus_7bdDXLpNtwdVCD",
      "discount": null,
      "ended_at": null,
      "metadata": {},
      "plan": {
        "id": "supporter",
        "object": "plan",
        "amount": 100,
        "created": 1451166160,
        "currency": "eur",
        "interval": "month",
        "interval_count": 1,
        "livemode": false,
        "metadata": {},
        "name": "Burn-Notice-Supporter",
        "statement_descriptor": null,
        "trial_period_days": null
      },
      "quantity": 1,
      "start": 1451166696,
      "status": "active",
      "tax_percent": null,
      "trial_end": null,
      "trial_start": null
    }
  },
  "livemode": false,
  "pending_webhooks": 0,
  "request": "req_7bdDyLfgk0lVvN",
  "type": "customer.subscription.created"
}
EVENT
