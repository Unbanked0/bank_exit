class ProjectsController < PublicController
  before_action :set_project, only: :show

  add_breadcrumb proc { I18n.t('application.header.home') }, :root_path
  add_breadcrumb proc { I18n.t('application.header.projects') }, :projects_path

  # @route GET /fr/projects {locale: "fr"} (projects_fr)
  # @route GET /es/projects {locale: "es"} (projects_es)
  # @route GET /de/projects {locale: "de"} (projects_de)
  # @route GET /it/projects {locale: "it"} (projects_it)
  # @route GET /en/projects {locale: "en"} (projects_en)
  # @route GET /projects
  def index
    @projects = Project.all(decorate: true)
  end

  # @route GET /fr/projects/:id {locale: "fr"} (project_fr)
  # @route GET /es/projects/:id {locale: "es"} (project_es)
  # @route GET /de/projects/:id {locale: "de"} (project_de)
  # @route GET /it/projects/:id {locale: "it"} (project_it)
  # @route GET /en/projects/:id {locale: "en"} (project_en)
  # @route GET /projects/:id
  def show
    add_breadcrumb @project.title, project_path(@project)

    set_meta_tags title: @project.title,
                  description: @project.overview
  end

  private

  def set_project
    @project = Project.find(identifier, decorate: true)
  end

  def identifier
    params[:id].presence || 'sticker'
  end
end
