class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category #{@category.name} added successfully!"
      redirect_to categories_path
    else
      flash[:failure] = "Sorry, that category name already exists. Please try again!"
      redirect_to new_category_path
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:success] = "Category #{@category.name} updated successfully!"
      redirect_to categories_path
    else
      redirect_to edit_category_path
    end
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy

    flash[:success] = "Category #{category.name} deleted successfully!"
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
