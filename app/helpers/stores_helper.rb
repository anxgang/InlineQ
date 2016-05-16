module StoresHelper
  def show_category_badge(category)
    if category.present?
      str = Store.where(category: category).count
      content_tag(:span, str, class: "badge") if str!=0
    end
  end

  def show_store_banner(store)
    if store.store_photo.present?
      str = image_tag(store.store_photo.image.url, class: "slide-image")
      content_tag(:a, str, href: store_path(store))
    else
      content_tag(:img, "", src: "http://placehold.it/800x300", class: "slide-image")
    end
  end

  def show_store_img(store, size)
    if store.store_photo.present?
      if size!=''
        str = image_tag(store.store_photo.image.size.url)
      else
        str = image_tag(store.store_photo.image.url)
      end
      content_tag(:div, str, style: "background: #ddd; height: 150px")
    else
      content_tag(:img, "", src: "http://placehold.it/320x180")
    end
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
      @number.present? ? @number.number : 0
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
