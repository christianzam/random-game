module TournamentsHelper
  def tournament_pic(tournament, class_name='')
    if tournament.tournament_picture.attached?
      image_tag tournament.tournament_picture, class: "#{class_name}", alt: 'pic'
    else
      content_tag(:div, 'No pic attached', class: 'flex justify-center p-5')
    end
  end
end