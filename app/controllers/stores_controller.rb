class StoresController < ApplicationController
  def index
    @stores = Store.all
  end

  def new
    @store = Store.new
  end

  def create
    @store = Store.new(store_params)
    @store.user_id = current_user.id
    if @store.save
      redirect_to stores_path, notice: '已成功建立商店！'
    else
      render :new, alert: '建立商店錯誤！'
    end
  end

  def edit
    @store = Store.find(params[:id])
  end

  def update
    @store = Store.find(params[:id])
    if @store.update(store_params)
      redirect_to stores_path, notice: '已成功更新商店！'
    else
      render :new, alert: '更新商店錯誤！'
    end
  end

  def show
    @store = Store.find(params[:id])
  end

  def destroy
    @store = Store.find(params[:id])
    @store.destroy
    redirect_to root_path, notice: '已成功刪除商店！'
  end

  def line_up
    @store = Store.find(params[:id])

    @exist_number = Number.where(store_id: @store.id, user_id: current_user.id).order('number DESC').take
    if @exist_number.present?
      return redirect_to store_path(@store), alert: "您已經在隊列中了，您的號碼為#{@exist_number.number}！"
    end

    @new_number = get_new_number(@store)
    @number = Number.new({store_id: @store.id, user_id: current_user.id, number: @new_number})
    if @number.save
      redirect_to store_path(@store), notice: "已成功排隊囉，號碼為#{@new_number}！"
    else
      render :show
    end
  end

  private

  def get_new_number(store)
    @number = Number.where(store_id: store.id).order('number DESC').first(1)
    @number.present? ? @number.number + 1 : 1
  end

  def store_params
    params.require(:store).permit(:name, :tel, :content)
  end

end
