class TodosController < ApplicationController
  def index
  end

  def all_todos
    complete = Todo.where(complete: true)
    incomplete = Todo.where(complete: false)
    render json: {complete: complete, incomplete: incomplete}
  end
end
