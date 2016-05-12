module StoresHelper
  def store_user_email(user_id)
    if user_id
      @user = User.find(user_id)
      @user.email
    end
  end

  def store_line_number(store_id)
    if store_id
      @number = Number.where(store_id: store_id).order('number DESC').take
      @number.present? ? @number.number : 'NA'
    end
  end

  def user_line_number(store_id)
    if store_id && user_signed_in?
      @number = Number.where(store_id: store_id, user_id: current_user.id).order('number DESC').take
      @number.present? ? @number.number : 'NA'
    end
  end

end
