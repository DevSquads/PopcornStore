require 'rails_helper'

def parsed_response_body
  JSON.parse(response.body)
end

RSpec.describe "/orders", type: :request do
  describe "GET /index" do
    it "renders a successful response" do
      Order.create!({popcorn_id: Popcorn.new(flavor: 'Caramel', price: 18.81).id, quantity: 3})

      get orders_url, as: :json

      expect(response).to be_successful
      expect(parsed_response_body.count).to eq(1)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      order = Order.create!({popcorn_id: Popcorn.new(flavor: 'Caramel', price: 18.81).id, quantity: 3})

      get order_url(order), as: :json

      expect(response).to be_successful
      expect(parsed_response_body['popcorn_id']).to eq(order.popcorn_id)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Order" do
        popcorn = Popcorn.new(flavor: 'Caramel', price: 18.81)
        expect {
          post orders_url,
               params: {order: {popcorn_id: popcorn.id, quantity: 3}}, as: :json
        }.to change(Order, :count).by(1)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Order" do
        post orders_url, params: {order: {}}, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "renders a JSON response with errors for the new order" do
        post orders_url,
             params: {order: {}}, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      it "updates the requested order" do
        order = Order.create!({popcorn_id: Popcorn.new(flavor: 'Caramel', price: 18.81).id, quantity: 3})

        patch order_url(order),
              params: {order: {quantity: 4}}, as: :json

        order.reload
        expect(parsed_response_body['quantity']).to eq(4)
      end

      it "renders a JSON response with the order" do
        order = Order.create!({popcorn_id: Popcorn.new(flavor: 'Caramel', price: 18.81).id, quantity: 3})

        patch order_url(order),
              params: {order: {quantity: 5}}, as: :json

        expect(response).to have_http_status(:ok)
        expect(parsed_response_body['quantity']).to eq(5)
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the order" do
        order = Order.create!
        patch order_url(order),
              params: {order: {}}, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
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
