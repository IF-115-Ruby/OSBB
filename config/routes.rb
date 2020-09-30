Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  %w( 404 422 500 ).each do |code|
  get code, controller: :application, action: :error, code: code
  end
end
