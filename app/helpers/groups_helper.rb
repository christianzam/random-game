module GroupsHelper
  def names(group)
    return if group.members.empty?

    data = []

    group.members.each do |member|
      next if member == " "

      data << tag.li(class: 'mt-1') do
        content = ''
        content << member
        content.html_safe
      end
    end

    safe_join(data)
  end
end