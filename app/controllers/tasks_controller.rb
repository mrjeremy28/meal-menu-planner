class TasksController < ApplicationController
  # before_action :set_breadcrumbs
  def index
    # @page = params[:page].to_i
    @tasks = Task.order(:position)
    add_breadcrumb("Home", "/")
    add_breadcrumb("Tasks")
  end

  def show
    @task = Task.find(params[:id])
    add_breadcrumb("Home", "/")
    add_breadcrumb("Tasks", tasks_path)
    add_breadcrumb(@task.name)
  end

  def new
    @count = Task.count
    @task = Task.new(position: @count + 1)
    add_breadcrumb("Home", "/")
    add_breadcrumb("Tasks", tasks_path)
    add_breadcrumb("New")
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path
    else
      # new action is not being called, it's rendering "New" view
      # assign any instance variable
      # @count = Task.count
      render(:new, status: 422)
    end
  end

  def edit
    @task = Task.find(params[:id])
    add_breadcrumb("Home", "/")
    add_breadcrumb("Tasks", tasks_path)
    add_breadcrumb(@task.name, task_path(@task))
    add_breadcrumb("Edit")
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to task_path(@task)
    else
      render(:edit, status: 422)
    end

  end

  def delete
    @task = Task.find(params[:id])
    add_breadcrumb("Home", "/")
    add_breadcrumb("Tasks", tasks_path)
    add_breadcrumb("Delete")
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  private
  def set_breadcrumbs
    add_breadcrumb("Home", "/")
    add_breadcrumb("Tasks")
  end
  def task_params
    params.require(:task).permit(:name, :position, :completed, :description, :category_id, tag_ids: [])
  end
end
