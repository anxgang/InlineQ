module StoresHelper
  #是否在隊列中
  def is_in_line(store_id)
    @number = Number.where(store_id: @store.id, user_id: current_user.id).order('number DESC').take
    @number.present? ? @number.number : nil
  end


  # 擁有商店的使用者email
  def store_user_email(user_id)
    if user_id
      @user = User.find(user_id)
      @user.email
    end
  end

  # 目前商店叫號
  def store_current_number(store_id)
    if store_id
      @number = Store.find(store_id)
      @number!=0 ? @number.current_number : nil
    end
  end

  # 目前排隊最新號碼
  def store_line_number(store_id)
    if store_id
      @number = Number.where(store_id: store_id).order('number DESC').take
      @number.present? ? @number.number : nil
    end
  end

  # 使用者目前排隊號碼
  def user_line_number(store_id)
    if store_id && user_signed_in?
      @number = Number.where(store_id: store_id, user_id: current_user.id).order('number DESC').take
      @number.present? ? @number.number : nil
    end
  end

end
