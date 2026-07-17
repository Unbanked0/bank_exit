class DirectoryDecorator < ProfesionalDecorator
  def friendly_category
    return I18n.t('unknown') if category.blank?

    I18n.t(category,
           scope: :directories_categories,
           default: category&.titleize)
  end
end
