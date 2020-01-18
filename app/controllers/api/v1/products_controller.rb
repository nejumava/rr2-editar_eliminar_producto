class Api::V1::ProductsController < ApplicationController
    protect_from_forgery with: :null_session

    def index
        @products = Product.all
        render json: @products
    end

    def create
        @product = Product.new(product_params)
        if @product.save
            render json: @product, status: 201
        else
            render json: { errors: @product.errors }, status: 422
        end
    end

    def update
        @product = Product.find(params[:id])
        if @product.update(product_params)
            render json: @product
        else
            render json: { errors: @product.errors }, status: 422
        end
    end

    def destroy
       @product = Product.find(params[:id])
       @product.destroy
       
       head :no_content, status: 204
    end

    private
    def product_params
        params.require(:product).permit(:name, :price)
    end
end