module MembersHelper
  def available_santas
    return "No available Santas left" if Member.where(give_to: nil).empty?
    
    data = []
    Member.where(give_to: nil).each do |member|
      data << tag.li(class:"list-none my-5") do
        content = ''
        content << tag.div(class:"text-center text-xl") do "#{member.nickname.upcase}" end
        content << tag.br
        content << tag.div(class:"text-center text-xl") do "Hobbies" end
        content << tag.li(class:"text-center text-xl") do "#{member.interests['activity']}" end
        content << tag.li(class:"text-center text-xl") do "#{member.interests['activity_2']}" end
        content << tag.br
        content << tag.hr(class:"my-2 mx-auto w-48 h-1 bg-red-900 rounded border-0 md:my-5 dark:bg-red-900")
        content.html_safe
      end
    end
    safe_join(data)
  end
end
