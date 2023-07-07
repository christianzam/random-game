module Pages::DrawsHelper
  def print_result(result)
    return 'Result is empty' if result.nil?
    return 'Not enough people' if result.size == 1
    return 'Add someone else, just 2 people is boring' if result.size <= 2

    data = []
    result.each_with_index do |pair, idx|
      data << tag.li(class:"list-none my-5") do
        content = ''
        content << tag.span(class:"text-center text-white text-xl") do "#{idx + 1}#{(idx + 1).ordinal} 🎅 pair" end
        content << tag.br
        content << tag.br
        content << tag.span(class:"text-center text-white text-xl") do
           "#{pair.first.upcase}.... is giving to.... #{pair.second.upcase}!!" 
        end
        content << tag.br
        content << tag.hr(class:"border-4 border-red-700")
        content.html_safe # rubocop:disable Rails/OutputSafety
      end
    end
    safe_join(data)
  end

  def draw_titles(group_id)
    nicknames = Group.find_by(id: group_id).members
    return if nicknames.empty?

    data = []
    data << tag.div(class: "text-center text-red-900", style:"font-size:xx-large;" ) do 
      nicknames.size >= 2 ? "#{nicknames.size} Santas ready for draw" : "Only #{nicknames.first} for a draw 🙁" 
    end

    safe_join(data)
  end

  def draw_btn(group_id)
    title = Group.find_by(id: group_id).draw_performed? ? 'Re-Start Draw' : 'Start Draw'

    form_tag draws_path(id: group_id), method: :post do
      submit_tag "#{title}", class: 'bg-green-900 hover:bg-green-700 cursor-pointer text-white font-bold py-2 px-4 rounded'
    end
  end
end