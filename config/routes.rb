Rails.application.routes.draw do
  get 'hotels/sync_data' => 'hotels#sync_data'
  get '/' => 'hotels#index'
  resources :hotels
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
