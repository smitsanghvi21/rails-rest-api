class Api::V1::FactsController < ApplicationController
    before_action :find_fact, only:[:show,:update,:destroy]
    #get /users
    def index
        @facts=Fact.all
        render json:@facts
    end
    #get /users/:id
    def show
        @fact=find_fact
        render json:@fact
    end

    #post /users
    def create
        @fact=Fact.new(fact_params)
        if @fact.save
            render json:@fact
        else
            render json:{error:"unable to create fact "}, status:400
        end
    end

    #post /users/:id
    def update
        @fact=find_fact
        if @fact
            @fact.update(fact_params)
            render json:{error:"fact updated"},status:200
        else
            render json:{error:"unable to update fact "}, status:400
        end
    end

    def destroy
        @fact=find_fact
        if @fact
            @fact.destroy
            render json:{error:"fact deleted"},status:200
        else
            render json:{error:"unable to delete fact "}, status:400
        end
    end

    def find_fact
        Fact.find(params[:id])
    end

    private
    def fact_params
        params.required(:fact).permit(:fact,:likes, :user_id)
    end
end
