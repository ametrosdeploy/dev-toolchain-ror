class Api::Admin::V1::CharactersController < Api::Admin::V1::BaseController
  before_action :authenticate_user!
  before_action :set_character, only: %i[show update destroy remove_photo
                                                       assign_organization_role]

  def index
    @characters = Character.all.with_attached_photo
    @characters = @characters.search(params[:search]) if params[:search].present?
    @characters = @characters.order("#{sort_column} #{sort_order}")
    @characters = @characters.paginate(page: params[:page], per_page: Character::PER_PAGE)
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
    unless @character.world_org_characters.present?
      @character.destroy
    else
      render json: { errors: "It is linked with world and can not be deleted" }, status: :unprocessable_entity
    end
  end

  def assign_organization_role
    @org_character = @character.organization_characters.build(organization_character_params)
    if @org_character.save
      render json: @org_character, status: 200
    else
      render json: @character.errors, status: :unprocessable_entity
    end
  end

  # Removed Character Photo
  def remove_photo
    @character.photo.try(:purge)
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
    param :query, 'sort_order', :string, :optional, 'Options: "asc", "desc"'
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

  swagger_api :assign_organization_role do
    summary 'Assign organization and role to character'
    notes 'Should be used to assign organization and role to character'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'Character Id'
    param :form, 'organization_character[organization_id]', :string, :required, 'organization_id'
    param :form, 'organization_character[world_role_id]', :string, :optional, 'world_role_id'
    response :unauthorized
  end

  swagger_api :remove_photo do
    summary 'Destroys photo of character'
    notes 'Should be used to destroy photo of character'
    param :header, :Authorization, :string, :required, 'Authorization'
    param :path, 'id', :string, :required, 'character Id'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_character
    @character = Character.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def character_params
    params.require(:character).permit(:first_name, :last_name, :age,
                                      :gender, :real_world, :photo)
  end

  def organization_character_params
    params.require(:organization_character).permit(:organization_id, :world_role_id)
  end

  def serializer
    CharacterSerializer
  end

  # Set default sort Column
  def sort_column
    valid_sort && params[:sort_column].split(',').join(" #{sort_order}, ") || 'id'
  end

  # Validate sort key & set default sort type
  def sort_order
    sort_type = params[:sort_order]
    sort_type.present? && %w[asc desc].include?(sort_type) && sort_type || 'desc'
  end

  # Verify available sort options
  def valid_sort
    params[:sort_column].present? && ['first_name,last_name', 'created_at',
     'age', 'gender', 'organizations_count'].include?(params[:sort_column])
  end

end
