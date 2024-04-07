class CategoriesController < ApplicationController
  before_action :set_breadcrumbs, only: [:show, :new, :edit, :delete]

  def index
    @categories = Category.order(:name)
    add_breadcrumb("Home", "/")
    add_breadcrumb("Categories")
  end

  def show
    @category = Category.find(params[:id])
    add_breadcrumb(@category.name)
  end

  def new
    @category = Category.new
    add_breadcrumb("New")
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to(categories_path)
    else
      render('new')
    end
  end

  def edit
    @category = Category.find(params[:id])
    add_breadcrumb(@category.name, categories_path(@task))
    add_breadcrumb("Edit")
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to(categories_path)
    else
      render('edit')
    end
  end

  def delete
    @category = Category.find(params[:id])
    add_breadcrumb("Delete")
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to(categories_path)
  end

  private

  def set_breadcrumbs
    add_breadcrumb("Home", "/")
    add_breadcrumb("Categories", categories_path)
  end

  def category_params
    params.require(:category).permit(:name)
  end

end
