class ListsController < ApplicationController


  respond_to :html, :js


  def index
  end


  def show
  end


  def create
  end


  def update
  end


  def destroy
  end


  def copy
  end


  private


  def list_params
    params.require(:list).permit(:user_id, :name)
  end


end
