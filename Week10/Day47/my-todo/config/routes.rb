Rails.application.routes.draw do
  # get 'todos/index'
  root to: "todos#index"
  get 'todos/all_todos'
  put 'todos/update'
end
