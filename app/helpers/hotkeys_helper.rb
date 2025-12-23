module HotkeysHelper
  def hotkey_label(hotkey, size: 'sm')
    # kbd-xs / kbd-sm
    klass = "kbd kbd-#{size} text-base-content hide-on-touch"

    content_tag :span, class: 'hide-on-touch' do
      if hotkey.is_a?(Array)
        hotkey.map do |key|
          tag.kbd(key.capitalize, class: klass)
        end.join('&nbsp;+&nbsp;').html_safe
      else
        tag.kbd(hotkey.capitalize, class: klass).html_safe
      end
    end
  end
end
