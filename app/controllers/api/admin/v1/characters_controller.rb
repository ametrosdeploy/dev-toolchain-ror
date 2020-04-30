class Api::Admin::V1::CharactersController < Api::Admin::V1::BaseController
  before_action :authenticate_user!
  before_action :set_character, only: %i[show update destroy assign_organization_role]

  def index
    @characters = Character.all.with_attached_photo
    if params[:search].present?
      @characters = @characters.where("concat(first_name,' ',last_name) ilike ?",
                                      "%#{params[:search]}%")
    end
    @characters = @characters.order("#{sort_column} #{sort_order}")
    @characters = @characters.paginate(page: params[:page], per_page: 10)
    render json: serialize_rec(@characters).merge!(pagination_hsh(@characters, Character))
  end

  def show
    render json: serialize_rec(@character)
  end

  def create
    @character = Character.new(character_params)
    if @character.save
      render json: serialize_rec(@character), status: :created
    else
      render json: @character.errors, status: :unprocessable_entity
    end
  end

  def update
    if @character.update(character_params)
      render json: serialize_rec(@character)
    else
      render json: @character.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @character.destroy
  end

  def assign_organization_role
    @character.organization_character.build(world_role_id: params[:world_role_id],
       organization_id: params[:organization_id])
  end

  swagger_controller :characters, 'Character', resource_path: '/api/admin/v1/characters'

  swagger_api :index do
    summary 'List characters'
    notes 'Should be used to List characters'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :query, 'page', :string, :optional, 'Page Number'
    param :query, 'search', :string, :optional, 'Search Parameter'
    param :query, 'sort_column', :string, :optional, 'Options: "first_name,last_name", "created_at", "age",
        "gender", "organizations_count"'
    param :query, 'sort_order', :string, :optional, 'Options: "asc", "dsc"'
  end

  swagger_api :create do
    summary 'Creates a new character'
    notes 'Should be used to create character'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :form, 'character[first_name]', :string, :required, 'first_name'
    param :form, 'character[last_name]', :string, :optional, 'last_name'
    param :form, 'character[age]', :integer, :required, 'age'
    param :form, 'character[gender]', :string, :required, 'gender Options: male, female, other'
    param :form, 'character[real_world]', :boolean, :required, 'real_world'
    param :form, 'character[photo]', :string, :optional, 'photo(Does not work)'
    response :unauthorized
  end

  swagger_api :show do
    summary 'Show character'
    notes 'Should be used to show character'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'Character Id'
  end

  swagger_api :update do
    summary 'Update character'
    notes 'Should be used to update character'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'World Id'
    param :form, 'character[first_name]', :string, :required, 'first_name'
    param :form, 'character[last_name]', :string, :optional, 'last_name'
    param :form, 'character[age]', :integer, :required, 'age'
    param :form, 'character[gender]', :string, :required, 'gender Options: male, female, other'
    param :form, 'character[real_world]', :boolean, :required, 'real_world'
    param :form, 'character[photo]', :string, :optional, 'photo(Does not work)'
    response :unauthorized
  end

  swagger_api :destroy do
    summary 'Destroys a character'
    notes 'Should be used to destroy a character'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'Character Id'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_character
    @character = Character.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def character_params
    Rails.logger.info(params.inspect)
    params.require(:character).permit(:first_name, :last_name, :age,
                                      :gender, :real_world, :photo)
  end

  def serializer
    CharacterSerializer
  end

  def sort_column
    valid_sort && params[:sort_column] || 'id'
  end

  def sort_order
    sort_type = params[:sort_type]
    sort_type.present? && %w[asc dsc].include?(sort_type) && sort_type || 'desc'
  end

  def valid_sort
    params[:sort_column].present? && ['first_name,last_name', 'created_at', 'age',
                                      'gender', 'organizations_count'].include?(params[:sort_column])
  end
end
