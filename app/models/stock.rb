class Stock < ApplicationRecord
    
    has_many :user_stocks
    has_many :users, through: :user_stocks

    validates(:name, :ticker, presence: true)

    def self.new_lookup(ticker_symbol)
        client = IEX::Api::Client.new(
            publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
            secret_token: Rails.application.credentials.iex_client[:secret_token],
            endpoint: 'https://sandbox.iexapis.com/v1'
        )

        begin
            new(ticker: ticker_symbol, 
                name: client.company(ticker_symbol).company_name, 
                last_price: client.ohlc(ticker_symbol).close.price,
                dividend_yield: client.key_stats(ticker_symbol).dividend_yield,
                ex_dividend_date: client.key_stats(ticker_symbol).ex_dividend_date,
                current_price: client.quote(ticker_symbol).latest_price
            )
        rescue => exception
            return nil
        end
        
    end

    def self.check_db(ticker_symbol)
        where(ticker: ticker_symbol).first
    end
end
