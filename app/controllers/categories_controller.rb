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

    respond_to do |format|
      if @category.save
        format.html { redirect_to category_url(@category), notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
    # if @category.save
    #   redirect_to(categories_path)
    # else
    #   render('new', status: 422)
    # end
  end

  def edit
    @category = Category.find(params[:id])
    add_breadcrumb(@category.name, category_path(@category))
    add_breadcrumb("Edit")
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to(category_path)
    else
      render('edit', status: 422)
    end
  end

  def delete
    @category = Category.find(params[:id])
    add_breadcrumb(@category.name, category_path(@category))
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
