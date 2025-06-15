module Admin
  class ApplicationController < ApplicationController
    include HttpAuthConcern

    layout 'admin'
  end
end
