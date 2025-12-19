module HotkeysHelper
  def hotkey_label(hotkey, size: 'sm')
    # kbd-xs / kbd-sm
    klass = "kbd kbd-#{size} text-base-content hide-on-touch"

    if hotkey.is_a?(Array)
      hotkey.map do |key|
        tag.kbd(key.capitalize, class: klass)
      end.join('&nbsp;+&nbsp;')
    else
      tag.kbd(hotkey.capitalize, class: klass)
    end
  end
end
