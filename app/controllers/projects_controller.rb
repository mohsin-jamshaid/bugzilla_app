class ProjectsController < ApplicationController
  before_action :find_project, except: %i[index new create]

  append_before_action :authorize_project, except: %i[index new create]

  after_action :verify_policy_scoped, only: :index

  def index
    @projects = policy_scope(Project)
  end

  def new
    @project = Project.new

    authorize_project
  end

  def create
    @project = current_user.created_projects.build(project_params)

    authorize @project

    if @project.save
      flash[:success] = 'Project has been created successfully'
      redirect_to projects_path

    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @project.update(project_params)
      flash[:success] = 'Project has been updated successfully'
      redirect_to projects_path

    else
      render 'edit'
    end
  end

  def show
    @project_users = @project.users
    @nonproject_users = User.where.not(user_type: 'manager', id: @project_users.ids)

    @bugs = @project.bugs.order('deadline').with_attached_image
  end

  def destroy
    @project.destroy

    respond_to do |format|
      format.json do
        render json: {}
      end
    end
  end

  def assign_project
    @project.users << User.find(params[:user_id])

    flash[:success] = 'Project has been successfully assigned to user'
    redirect_to project_path
  end

  def remove_from_project
    @project.users.destroy(User.find(params[:user_id]))

    flash[:success] = 'User has been successfully removed from Projects'
    redirect_to project_path
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title)
  end

  def authorize_project
    authorize @project
  end
end
