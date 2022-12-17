module DrawsHelper
  def print_result(result)
    return 'Result is empty' if result.nil?
    return 'Not enough people' if result.size == 1
    return 'Add someone else, just 2 people is boring' if result.size <= 2

    data = []
    result.each_with_index do |pair, idx|
      data << tag.li(class:"list-none my-5") do
        content = ''
        content << tag.span(class:"text-center text-white text-xl") do "#{idx + 1}#{(idx + 1).ordinal} pair" end
        content << tag.br
        content << tag.br
        content << tag.span(class:"text-center text-white text-xl") do
           "#{pair.first.upcase} Secret 🎅 is.... #{pair.second.upcase}!" 
        end
        content << tag.br
        content << tag.hr(class:"border-4 border-red-700")
        content.html_safe # rubocop:disable Rails/OutputSafety
      end
    end
    safe_join(data)
  end
end