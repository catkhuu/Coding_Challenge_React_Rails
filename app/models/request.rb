class Request
  extend ActiveModel::Naming

  BASE_URL = 'https://plated-coding-challenge.herokuapp.com'
  AUTHORIZATION_HEADER = {'Authorization': 'Token token=' + ENV['PLATED_API_KEY'], 'Accept': 'application/json'}

  def sort_response(response)
    response_body = response.body
    case response_body
    when Hash
      response_body['code'] = response.code
    when Array
      response_body.each { |item| item['code'] = response.code }
    when "null"
      response_body = nil
    when String
      response_body = { 'code' => response.code }
    end
    response_body
  end

  def get_menus
    sort_response(Unirest.get(BASE_URL + '/v1/menus.json', headers: AUTHORIZATION_HEADER))
  end

  def get_menu_title(menu_id)
    sort_response(Unirest.get(BASE_URL + "/v1/menus/#{menu_id}.json", headers: AUTHORIZATION_HEADER))
  end

  def create_a_menu(title)
    sort_response(Unirest.post(BASE_URL + '/v1/menus.json', headers: AUTHORIZATION_HEADER, parameters: { 'menu': { 'title': title } }))
  end

  def update_menu(menu_id, title)
    sort_response(Unirest.put(BASE_URL + "/v1/menus/#{menu_id}.json", headers: AUTHORIZATION_HEADER, parameters: { 'menu': { 'title': title } }))
  end

  def delete_menu(menu_id)
    sort_response(Unirest.delete(BASE_URL + "/v1/menus/#{menu_id}.json", headers: AUTHORIZATION_HEADER))
  end

  def list_menu_recipes(menu_id)
    sort_response(Unirest.get(BASE_URL + "/v1/menus/#{menu_id}/recipes.json", headers: AUTHORIZATION_HEADER))
  end

  def add_recipe_to_menu(menu_id, recipe_id)
    sort_response(Unirest.post(BASE_URL + "/v1/menus/#{menu_id}/recipes", headers: AUTHORIZATION_HEADER, parameters: { 'recipe_id': recipe_id }))
  end

  def remove_recipe_from_menu(menu_id, recipe_id)
    sort_response(Unirest.delete(BASE_URL + "/v1/menus/#{menu_id}/recipes/#{recipe_id}.json", headers: AUTHORIZATION_HEADER))
  end

  def create_recipe(recipe_description, recipe_name)
    sort_response(Unirest.post(BASE_URL + '/v1/recipes.json', headers: AUTHORIZATION_HEADER, parameters: { 'recipe': { 'name': recipe_name, 'description': recipe_description } }))
  end

  def get_recipes
    sort_response(Unirest.get(BASE_URL + '/v1/recipes.json', headers: AUTHORIZATION_HEADER))
  end

  def get_recipe_description(recipe_id)
    sort_response(Unirest.get(BASE_URL + "/v1/recipes/#{recipe_id}.json", headers: AUTHORIZATION_HEADER))
  end

  def update_recipe(recipe_description, recipe_name, recipe_id)
    sort_response(Unirest.put(BASE_URL + "/v1/recipes/#{recipe_id}.json", headers: AUTHORIZATION_HEADER, parameters: { 'recipe': { 'name': recipe_name, 'description': recipe_description } }))
  end

  def delete_recipe(recipe_id)
    sort_response(Unirest.delete(BASE_URL + "/v1/recipes/#{recipe_id}.json", headers: AUTHORIZATION_HEADER))
  end
end
