class ListsController < ApplicationController


  respond_to :html, :js


  def index
    @list = List.new
    @lists = List.where("user_id=?", current_user.id)
  end


  def show
    @list = List.find(params[:id])
    @item = Item.new
  end


  def create
    list = List.new(list_params)
    list.user_id = current_user.id
    list.save!
    @lists = List.where("user_id=?", current_user.id)
    @list = List.new
  end


  def update
    list = List.find(params[:id])
    list.update_attributes(list_params)
    list.save!
    @lists = List.where("user_id=?", current_user.id)
    flash[:notice] = "List was updated."
    redirect_to list_path(list)
  end


  def destroy
    list = List.find(params[:id])
    list.destroy
    @lists = List.where("user_id=?", current_user.id)
    @list = List.new
    flash[:notice] = "List was deleted."
    redirect_to lists_path
  end


  #def copy
  #end


  private


  def list_params
    params.require(:list).permit(:name)
  end


end
