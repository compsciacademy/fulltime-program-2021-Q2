class TodosController < ApplicationController
  protect_from_forgery except: [:update]

  def index
  end

  def all_todos
    complete = Todo.where(complete: true)
    incomplete = Todo.where(complete: false)
    render json: {complete: complete, incomplete: incomplete}
  end

  def update
    json_params = JSON.parse(request.raw_post)
    todo = Todo.find(json_params["id"])
    if todo.update(json_params)
      render json: { message: "Updated successfully" }
    else
      render json: { message: "Something didn't work" }
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:id, :title, :complete)
  end
end
