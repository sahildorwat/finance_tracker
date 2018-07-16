class Stock < ApplicationRecord
    has_many :user_stocks
    has_many :users, through: :user_stocks

    def self.find_by_ticker(ticker)
        where(ticker: ticker).first
    end

    def self.search_stock(ticker)
        begin
            selected_stock = StockQuote::Stock.quote(ticker)
            new(name: selected_stock.company_name, 
                ticker: selected_stock.symbol, 
                last_price: selected_stock.latest_price)
        rescue Exception => e 
            return nil
        end
    end
end
