class StoresController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_store, only: [:edit, :update, :destroy, :show, :line_up, :next_one, :last_one]

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
  end

  def destroy
    @store.destroy
    redirect_to root_path, notice: '已成功刪除商店！'
  end

  # 加入排隊
  def line_up
    # 檢查是否已存在隊列中
    if is_in_line(@store.id)
      return redirect_to store_path(@store), alert: "您已經在隊列中了，您的號碼為#{@exist_number.number}！"
    end

    # 產生新排隊號碼
    @new_number = get_new_number(@store)
    @number = Number.new({store_id: @store.id, user_id: current_user.id, number: @new_number})
    if @number.save
      redirect_to store_path(@store), notice: "已成功排隊囉，號碼為#{@new_number}！"
    else
      render :show
    end
  end

  # 下一位
  def next_one
    @store.current_number += 1
    if @store.save
      redirect_to :back, notice: "已成功叫下一位囉，下一位為#{@store.current_number}!"
    else
      render :show
    end
  end

  # 上一位
  def last_one
    @store.current_number -= 1
    if @store.save
      redirect_to :back, notice: "已成功回到上一位囉，目前輪到#{@store.current_number}!"
    else
      render :show
    end
  end

  private

  def get_new_number(store)
    @number = Number.where(store_id: store.id).order('number DESC').take
    @number.present? ? @number.number + 1 : 1
  end

  def set_store
    @store = Store.find(params[:id])
  end

  def store_params
    params.require(:store).permit(:name, :tel, :content)
  end

end
