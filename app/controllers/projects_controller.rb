class ProjectsController < ApplicationController
  before_action :find_project, only: [:edit,:update,:show,:destroy, :assign_project, :remove_from_project]

  def index
    if current_user.manager?
      @projects = Project.where(creator_id:current_user.id)
    
    else
      @projects = @current_user.projects
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project =  Project.new(project_params)

    if @project.save
      redirect_to projects_path, notice: 'Project has been created successfully'
    
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to projects_path, notice: 'Project has been updated successfully'
  
    else
      render 'edit'
    end
  end

  def show
    @users = User.where.not(user_type: 'manager').includes(:projects)
    @project_users = @project.users
    @nonproject_users = User.where.not(user_type: 'manager', id: @project_users.ids)
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: 'Project has been successfully destroyed'
  end

  def assign_project
    @project.users << User.find(params[:user_id])
    redirect_to project_path, notice: 'Project has been successfully assigned to user'
  end

  def remove_from_project
    @project.users.destroy(User.find(params[:user_id]))
    redirect_to project_path, notice: 'User has been successfully removed from Projects'
  end

  private
    def find_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:title, :creator_id)
    end
end
