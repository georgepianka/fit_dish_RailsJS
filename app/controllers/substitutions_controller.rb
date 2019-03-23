class SubstitutionsController < ApplicationController
    def new
        @substitution = Substitution.new
    end

    def index
        
    end

    def show

    end


    def create

    end

    private
        def substitutions_params
            params.require(:substitution).permit(:user_id, :recipe_id, :name, :description)
        end
end
