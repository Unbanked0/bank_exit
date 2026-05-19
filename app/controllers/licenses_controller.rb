class LicensesController < ApplicationController
  allow_unauthenticated_access

  # @route GET /license (license)
  def show
    render file: 'public/license_for_project.html', layout: false
  end
end
