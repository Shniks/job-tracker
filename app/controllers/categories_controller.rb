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
      flash[:success] = "#{@category.name} added!"
      redirect_to category_path(@category)
    else
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
      flash[:success] = "#{@category.name} updated!"
      redirect_to category_path(@category)
    else
      redirect_to edit_category_path
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
