Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/projects", to: "project#index"
  patch "/projects/:project_id/todos/:todo_id", to: "project#do"
  post "/todos", to: "project#new"

end
