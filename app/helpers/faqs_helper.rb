module FAQsHelper
  # This method parses FAQ content that have some {{mustach}}
  # dynamic variables such as a Rails route.
  def parsed_faq_answer(answer)
    mustaches = answer.scan(/\{\{[^}]+\}\}(?!\})/)
    mustaches.each do |mustache|
      mustache.gsub!('{{', '').gsub!('}}', '')

      delimiters = ['#', '->']
      controller, action, id = mustache.split(Regexp.union(delimiters))

      link = url_for(controller: controller, action: action, id: id)
      answer.gsub!(mustache, link_to(link, link))
            .gsub!('{{', '')&.gsub!('}}', '')
    end

    answer
  end
end
