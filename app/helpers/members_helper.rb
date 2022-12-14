module MembersHelper
  def available_santas
    return if Member.where(user_id: nil).empty?
    
    data = []
    Member.where(user_id: nil).each do |member|
      data << tag.li(class:"list-none my-5") do
        content = ''
        content << tag.span(class:"text-center text-xl") do "#{member.nickname.upcase}" end
        content << tag.br
        content << tag.br
        content << tag.span(class:"text-center text-xl") do
           "Hobbies: #{member.interests['activity']} and #{member.interests['activity_2']}" 
        end
        content << tag.br
        content << tag.hr(class:"border-4 border-red-700")
        content.html_safe # rubocop:disable Rails/OutputSafety
      end
    end
    safe_join(data)
  end
end
