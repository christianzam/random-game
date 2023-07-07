module ApplicationHelper
  def user_profile_pic(user, class_name='')
    if user.profile_pic.attached?
      image_tag user.profile_pic, class: "placeholder-image #{class_name}", alt: 'user_pic'
    else
      image_tag 'fa-solid fa-user', class: "placeholder-image #{class_name}", alt: 'user_pic'
    end
  rescue StandardError
    image_tag 'gifts.png', class: 'placeholder-image', alt: 'user_pic'
  end
end
