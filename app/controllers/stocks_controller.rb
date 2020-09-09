class StocksController < ApplicationController

    def search
        puts 'stock search 1'
        if params[:stock].present?
            puts 'stock search 2'

            @stock = Stock.new_lookup(params[:stock].upcase)
            if @stock
                puts 'stock search 3'

                respond_to do |format|
                    format.js { render partial: 'users/result' }
                end
            else    
                puts 'stock search 4'

                respond_to do |format|
                    flash.now[:alert] = "Please enter a valid symbol to search"
                    format.js { render partial: 'users/result' }
                end
            end
        else
            respond_to do |format|
                flash.now[:alert] = "Please enter a symbol to search"
                format.js { render partial: 'users/result' }
            end
        end
    end
end
