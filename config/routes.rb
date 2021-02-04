Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :users, only: [] do
        member do
          get :balance
        end
      end
    end
  end
end
