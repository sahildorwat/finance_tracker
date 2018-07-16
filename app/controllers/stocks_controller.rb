class StocksController < ApplicationController
    def search 
        if params[:stock].blank?
            flash.now[:danger] = "You have entered empty String"
        else
            @stock =  Stock.search_stock(params[:stock])
            flash.now[:danger] = 'You have entered invalid symbol' unless @stock
        end
        respond_to do |format|
            format.js {render partial: 'users/result'}
        end
    end

end