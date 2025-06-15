class QuestionsController < ApplicationController
  # @route GET /fr/questions/results {locale: "fr"} (results_questions_fr)
  # @route GET /es/questions/results {locale: "es"} (results_questions_es)
  # @route GET /en/questions/results {locale: "en"} (results_questions_en)
  # @route GET /questions/results
  def results
    response = Questions::BuildResponse.call(
      profile, level, service
    )

    if response[:type] == :redirect
      if response[:id]
        redirect_to send(response[:to], id: response[:id])
      else
        redirect_to send(response[:to])
      end
    else
      @profile = profile
      @level = level
      @service = service

      @profiles = Questions::BuildProfiles.call
      @levels = Questions::BuildLevels.call
    end
  end

  # @route POST /fr/questions/fetch_levels {locale: "fr"} (fetch_levels_questions_fr)
  # @route POST /es/questions/fetch_levels {locale: "es"} (fetch_levels_questions_es)
  # @route POST /en/questions/fetch_levels {locale: "en"} (fetch_levels_questions_en)
  # @route POST /questions/fetch_levels
  def fetch_levels
    @levels = Questions::BuildLevels.call(profile)

    respond_to do |format|
      format.turbo_stream
    end
  end

  # @route POST /fr/questions/fetch_services {locale: "fr"} (fetch_services_questions_fr)
  # @route POST /es/questions/fetch_services {locale: "es"} (fetch_services_questions_es)
  # @route POST /en/questions/fetch_services {locale: "en"} (fetch_services_questions_en)
  # @route POST /questions/fetch_services
  def fetch_services
    @services = Questions::BuildServices.call(profile, level)

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def questions_params
    params.expect(questions: %i[profile level service])
  end

  def profile
    @profile ||= questions_params[:profile].presence || 'individual'
  end

  def level
    @level ||= questions_params[:level]
  end

  def service
    @service ||= questions_params[:service]
  end
end
