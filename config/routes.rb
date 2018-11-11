Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1, path: "/" , constraints: ApiVersionConstraint.new(version: 1, default: true) do
    #routes
  end
end
