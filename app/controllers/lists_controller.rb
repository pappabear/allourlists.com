class ListsController < ApplicationController


  respond_to :html, :js


  def index
    @list = List.new
    @lists = List.all
  end


  def show
    @list = List.find(params[:id])
  end


  def create
    list = List.new(list_params)
    list.save!
    @lists = List.all
    @list = List.new
  end


  def update
    list = List.find(params[:id])
    list.update_attributes(list_params)
    list.save!
    @lists = List.all
    @list = List.new
  end


  def destroy
    list = List.find(params[:id])
    list.destroy
    @lists = List.all
    @list = List.new
  end


  #def copy
  #end


  private


  def list_params
    params.require(:list).permit(:name)
  end


end
