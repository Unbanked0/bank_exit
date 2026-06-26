module HotkeysHelper
  def hotkey_label(hotkey, size: 'sm')
    klass = "kbd kbd-#{size} text-base-content print:hidden hide-on-touch max-sm:hidden"

    if hotkey.is_a?(Array)
      content_tag :span, class: "hide-on-touch max-sm:hidden print:hidden text-#{size}" do
        hotkey.map do |key|
          tag.kbd(key.capitalize, class: "kbd kbd-#{size} text-base-content")
        end.join('&nbsp;+&nbsp;').html_safe # rubocop:disable Rails/OutputSafety
      end
    else
      tag.kbd(hotkey.capitalize, class: klass).html_safe # rubocop:disable Rails/OutputSafety
    end
  end
end
