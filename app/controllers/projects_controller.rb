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

    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def create
    @project = current_user.created_projects.build(project_params)

    authorize @project

    respond_to do |format|
      @project.save ? format.js { render layout: false } : format.js { render 'new.js.erb', layout: false }
    end
  end

  def edit
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def update
    respond_to do |format|
      @project.update(project_params) ? format.js { render layout: false } : format.js { render 'edit.js.erb', layout: false }
    end
  end

  def show
    @project_users = @project.users.with_attached_avatar
    @nonproject_users = User.where.not(user_type: 'manager', id: @project_users.ids).with_attached_avatar

    @bugs = @project.bugs.order('deadline').with_attached_image
  end

  def destroy
    @project.destroy

    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def assign_project
    @user = User.find(params[:user_id])

    @project.users << @user

    respond_to do |format|
      format.js { render layout: false }

      format.html { redirect_to project_path }
    end
  end

  def remove_from_project
    @user = User.find(params[:user_id])

    @project.users.destroy(@user)

    respond_to do |format|
      format.js { render layout: false }

      format.html { redirect_to project_path }
    end
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
