class ItemsController < ApplicationController


  respond_to :html, :js


  def create
  end


  def destroy
  end


  def mark_complete
  end


  def mark_incomplete
  end


  def sort
  end



  private



  def item_params
    params.require(:item).permit(:list_id, :name, :is_complete)
  end


end
