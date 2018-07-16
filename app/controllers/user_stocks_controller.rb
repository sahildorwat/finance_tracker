class UserStocksController < ApplicationController

    def create
        stock = Stock.find_by_ticker(params[:ticker])
        if(stock.blank?) 
            stock = Stock.search_stock(params[:ticker])
            stock.save
        end
        @user_stock = UserStock.create(user: current_user, stock: stock)
        flash[:success] = "Stock #{@user_stock.stock.name} was added successfully to portfolio"
        redirect_to my_portfolio_path
    end

    def destroy 
        stock = Stock.find(params[:id])
        @user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
        @user_stock.delete
        flash[:success] = "Stock deleted successfully from portfolio"
        redirect_to my_portfolio_path
    end

end
