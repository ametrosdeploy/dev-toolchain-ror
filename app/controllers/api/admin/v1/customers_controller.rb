# frozen_string_literal: true

# Customer controller
class Api::Admin::V1::CustomersController < Api::Admin::V1::BaseController
  include PaginateHsh
  before_action :authenticate_user!
  before_action :set_customer, only: %i[show update destroy]

  def index
    @customers = Customer.all
    render json: @customers
  end

  def show
    render json: @customer
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      render json: @customer, status: :created, location: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  def update
    if @customer.update(customer_params)
      render json: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @customer.destroy
  end

  # Needed to auto complete customer data
  def auto_comp_data
    @customers = Customer.all
    if params[:search].present?
      @customers = @customers.where('name ilike ?', "%#{params[:search]}%")
    end
    @customers = @customers.paginate(page: params[:page], per_page: 5)
    render json: serialize_rec(@customers).merge!(
      pagination_without_sort_hsh(@customers, Customer)
    )
  end

  swagger_controller :customers, 'Customer', resource_path:
    '/api/admin/v1/customers'

  swagger_api :auto_comp_data do
    summary 'Customer auto complete data'
    notes 'Should be used to auto complete customer data'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :query, 'page', :string, :optional, 'Page Number'
    param :query, 'search', :string, :optional, 'Search Parameter'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def customer_params
    params.require(:customer).permit(:name)
  end

  def serializer
    CustomerSerializer
  end
end
