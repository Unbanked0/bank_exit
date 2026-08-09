module HotkeysHelper
  def hotkey_label(hotkey, size: 'sm')
    kbd_size = case size
               when 'xs' then 'kbd-xs'
               when 'sm' then 'kbd-sm'
               end

    klass = "kbd #{kbd_size} print:hidden hide-on-touch max-sm:hidden js-only"

    if hotkey.is_a?(Array)
      content_tag :span, class: "hide-on-touch max-sm:hidden print:hidden text-#{size} js-only" do
        hotkey.map do |key|
          tag.kbd(key.capitalize, class: "kbd #{kbd_size}")
        end.join('&nbsp;+&nbsp;').html_safe # rubocop:disable Rails/OutputSafety
      end
    else
      tag.kbd(hotkey.capitalize, class: klass).html_safe # rubocop:disable Rails/OutputSafety
    end
  end
end
