module UsersHelper
  def user_roles_select_helper
    User.roles.keys.map do |role|
      [
        User.human_enum_name(:role, role),
        role
      ]
    end
  end

  def user_badge_color_for_role(role)
    {
      super_admin: 'badge-error',
      admin: 'badge-warning',
      publisher: 'badge-info',
      moderator: 'badge-success'
    }[role.to_sym]
  end

  def user_btn_color_for_role(role)
    {
      super_admin: 'btn-error',
      admin: 'btn-warning',
      publisher: 'btn-info',
      moderator: 'btn-success'
    }[role.to_sym]
  end

  def color_for_role(role)
    {
      super_admin: %w[bg-error text-error-content],
      admin: %w[bg-warning text-warning-content],
      publisher: %w[bg-info text-info-content],
      moderator: %w[bg-success text-success-content]
    }[role.to_sym]
  end
end
