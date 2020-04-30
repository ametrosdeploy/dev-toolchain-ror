Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: 'json' } do
      devise_for :users, singular: :user, path_names: {
        sign_in: 'login',
        sign_out: 'logout'
      },
                         controllers: {
                           sessions: 'api/v1/sessions'
                         }
    end
  end
end
