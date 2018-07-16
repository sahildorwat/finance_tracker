class Stock < ApplicationRecord
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
