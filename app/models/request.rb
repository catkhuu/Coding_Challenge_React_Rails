class Request
  extend ActiveModel::Naming

  BASE_URL = 'https://plated-coding-challenge.herokuapp.com'
  AUTHORIZATION_HEADER = {'Authorization': 'Token token=' + ENV['PLATED_API_KEY'], 'Accept': 'application/json'}

  def get_response_as_json(response)
    json = response.body
    if json.is_a? Hash
      json['code'] = response.code
    else
      json = { 'code' => response.code }
    end
    json
  end

  def create_a_menu(title)
    get_response_as_json(Unirest.post(BASE_URL + '/v1/menus.json', headers: AUTHORIZATION_HEADER, parameters: { 'menu': { 'title': title } }))
  end

  def update_menu(menu_id, title)
    get_response_as_json(Unirest.put(BASE_URL + "/v1/menus/#{menu_id}.json", headers: AUTHORIZATION_HEADER, parameters: { 'menu': { 'title': title } }))
  end

  def delete_menu(menu_id)
    get_response_as_json(Unirest.delete(BASE_URL + "/v1/menus/#{menu_id}.json", headers: AUTHORIZATION_HEADER))
  end

  def add_recipe_to_menu(menu_id, recipe_id)
    get_response_as_json(Unirest.post(BASE_URL + "/v1/menus/#{menu_id}/recipes", headers: AUTHORIZATION_HEADER, parameters: { 'recipe_id': recipe_id }))
  end

  def remove_recipe_from_menu(menu_id, recipe_id)
    get_response_as_json(Unirest.delete(BASE_URL + "/v1/menus/#{menu_id}/recipes/#{recipe_id}.json", headers: AUTHORIZATION_HEADER))
  end

  def create_recipe(recipe_description, recipe_name)
    get_response_as_json(Unirest.post(BASE_URL + '/v1/recipes.json', headers: AUTHORIZATION_HEADER, parameters: { 'recipe': { 'name': recipe_name, 'description': recipe_description } }))
  end

  def update_recipe(recipe_description, recipe_name, recipe_id)
    get_response_as_json(Unirest.put(BASE_URL + "/v1/recipes/#{recipe_id}.json", headers: AUTHORIZATION_HEADER, parameters: { 'recipe': { 'name': recipe_name, 'description': recipe_description } }))
  end

  def delete_recipe(recipe_id)
    get_response_as_json(Unirest.delete(BASE_URL + "/v1/recipes/#{recipe_id}.json", headers: AUTHORIZATION_HEADER))
  end
end
