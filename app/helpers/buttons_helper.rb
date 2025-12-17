module ButtonsHelper
  def raw_link_to(url, label: nil, hotkey: false, **, &block)
    base_link_to(
      url, label, nil, hotkey,
      **, &block
    )
  end

  def back_link_to(url, label: t('back'), hotkey: 'esc', **, &block)
    base_link_to(
      url, label, 'move-left', hotkey,
      class: 'btn btn-sm bg-base-300',
      **, &block
    )
  end

  def add_link_to(url, label: t('add'), hotkey: false, **, &block)
    base_link_to(
      url, label, 'circle-plus', hotkey,
      class: 'btn btn-sm btn-success',
      **, &block
    )
  end

  def create_link_to(url, label: t('create'), hotkey: false, **options, &block)
    base_link_to(
      url, label, 'circle-plus', hotkey,
      class: 'btn btn-sm btn-success',
      **options.merge(
        data: {
          turbo_method: :post,
          turbo_confirm: options[:turbo_confirm].presence || t('create_confirm')
        }
      ),
      &block
    )
  end

  def show_link_to(url, label: t('see'), hotkey: false, **, &block)
    base_link_to(
      url, label, 'eye', hotkey,
      class: 'btn btn-sm btn-info',
      **, &block
    )
  end

  def edit_link_to(url, label: t('edit'), hotkey: false, **, &block)
    base_link_to(
      url, label, 'pencil', hotkey ? 'e' : false,
      class: 'btn btn-sm btn-warning',
      **, &block
    )
  end

  def update_link_to(url, label: t('update'), hotkey: false, **options, &block)
    base_link_to(
      url, label, 'pencil', hotkey,
      class: 'btn btn-sm btn-success',
      **options.merge(
        data: {
          turbo_method: :patch,
          turbo_confirm: options[:turbo_confirm].presence || t('update_confirm')
        }
      ),
      &block
    )
  end

  def destroy_link_to(url, label: t('destroy'), hotkey: false, **options, &block)
    base_link_to(
      url, label, 'trash', hotkey,
      class: 'btn btn-sm btn-error',
      **options.merge(
        data: {
          turbo_method: :delete,
          turbo_confirm: options[:turbo_confirm].presence || t('destroy_confirm')
        }
      ),
      &block
    )
  end

  private

  def base_link_to(url, label, icon, hotkey, **options, &block)
    if hotkey
      options.deep_merge!(
        data: {
          controller: 'hotkey',
          action: "keydown.#{hotkey}@document->hotkey#click"
        }
      )
    end

    link_to(url, **options) do
      kbd = ''

      if hotkey.is_a?(String)
        hotkeys = hotkey.split('+')
        parts = hotkeys.map do |key|
          tag.kbd(key, class: 'kbd kbd-xs text-base-content uppercase hide-on-touch')
        end
        kbd = parts.join(' + ').html_safe # rubocop:disable Rails/OutputSafety
      end

      if block_given?
        content = capture(&block)
        kbd.present? ? content + kbd : content
      else
        (icon ? lucide_icon(icon, class: 'inline-flex w-4') : '') +
          (label ? tag.span(label, class: 'truncate') : '') +
          kbd
      end
    end
  end
end
