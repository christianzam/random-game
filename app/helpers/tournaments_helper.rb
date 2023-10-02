module TournamentsHelper
  def tournament_pic(tournament, class_name='')
    if tournament.tournament_picture.attached?
      image_tag tournament.tournament_picture, class: "#{class_name}", alt: 'pic'
    else
      content_tag(:div, class: 'flex justify-center p-5') do
        content_tag(:i, '', class: 'fas fa-trophy', style: 'font-size:80px;')
      end
    end
  end
end
