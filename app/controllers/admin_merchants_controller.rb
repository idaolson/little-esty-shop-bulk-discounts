  class AdminMerchantsController < ApplicationController
    def index
      @merchants = Merchant.all
    end

    def show
      @merchant = Merchant.find(params[:merchant_id])
    end

    def update
    end

    def create
    end
  end