require 'rails_helper'

RSpec.describe "/orders", type: :request do
  describe "GET /index" do
    it "renders a successful response" do
      Order.create!
      get orders_url, as: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body).count).to eq(1)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      order = Order.create!
      get order_url(order), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Order" do
        expect {
          post orders_url,
               params: { order: {} }, as: :json
        }.to change(Order, :count).by(1)
      end
    end

    xcontext "with invalid parameters" do
      it "does not create a new Order" do
        expect {
          post orders_url,
               params: { order: {} }, as: :json
        }.to change(Order, :count).by(0)
      end

      it "renders a JSON response with errors for the new order" do
        post orders_url,
             params: { order: {} }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      it "updates the requested order" do
        order = Order.create!
        patch order_url(order),
              params: { order: {} }, as: :json
        order.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the order" do
        order = Order.create!
        patch order_url(order),
              params: { order: {} }, as: :json
        expect(response).to have_http_status(:ok)
      end
    end

    xcontext "with invalid parameters" do
      it "renders a JSON response with errors for the order" do
        order = Order.create!
        patch order_url(order),
              params: { order: {} }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested order" do
      order = Order.create!
      expect {
        delete order_url(order), as: :json
      }.to change(Order, :count).by(-1)
    end
  end
end
