class ItemsController < ApplicationController


  respond_to :html, :js


  def create
    item = Item.new(item_params)
    item.list_id=params[:list_id]
    item.save!
    @item = Item.new
    @list = List.find(params[:list_id])
  end


  def update
    item = Item.find(params[:id])
    item.update_attributes(item_params)

    if !params[:item]['is_complete'].nil?
      item.is_complete = true
    else
      item.is_complete = nil
    end

    item.save!
    @item = Item.new
    @list = List.find(params[:list_id])
  end


  def destroy
    item = Item.find(params[:id])
    item.destroy
    @list = List.find(params[:list_id])
  end


  def mark_complete
    item = Item.find(params[:id])
    item.update_attribute('is_complete', true)
    item.save!
    @list = List.find(params[:list_id])
  end


  def mark_incomplete
    item = Item.find(params[:id])
    item.update_attribute('is_complete', nil)
    item.save!
    @list = List.find(params[:list_id])
  end


  def sort
    # puts 'sort params=' + params['item'].to_s
    @todos = Todo.where('id in (?)', params['item'])

    @todos.each do |w|
      w.position = params['item'].index(w.id.to_s) + 1
      w.save!
    end

    render :nothing => true
  end



  private



  def item_params
    params.require(:item).permit(:list_id, :name, :is_complete)
  end


end
