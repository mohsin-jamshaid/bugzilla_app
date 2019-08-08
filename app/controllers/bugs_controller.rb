class BugsController < ApplicationController
  before_action :find_bug, except: %i[index new create]
  before_action :find_project, except: :destroy

  append_before_action :authorize_bug_everytime, except: %i[new index create]
  append_after_action :authorize_bug_everytime, only: :new

  def index
    @bugs = @project.bugs.order('deadline')

    authorize @bugs
  end

  def new
    @bug = @project.bugs.build
  end

  def create
    @bug = @project.bugs.build(bug_params)

    authorize @bug

    if @bug.save
      flash[:success] = 'Bug has been successfully created'
      redirect_to project_bugs_path

    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @bug.update(bug_params)
      flash[:success] = 'Bug has been successfully updated'
      redirect_to project_bugs_path

    else
      render 'edit'
    end
  end

  def destroy
    @bug.destroy
    flash[:success] = 'Bug has been successfully destroyed'
    redirect_to project_bugs_path
  end

  def assign_bug
    if @bug.update(assign_to_id: current_user.id)
      @bug.set_bug_next_state!
      flash[:success] = 'Bug has been successfully assigned to user'

    else
      flash[:alert] = 'Cannot take bug deadline already passed'
    end

    redirect_to project_bugs_path(@project)
  end

  def resolve_bug
    if @bug.set_bug_next_state!
      flash[:success] = 'Bug is successfully resolved'

    else
      flash[:alert] = 'Cannot resolve bug you may have pass the deadline,wait for QA to edit the deadline'
    end

    redirect_to project_bugs_path(@project)
  end

  private

  def bug_params
    params.require(:bug).permit(:title, :deadline, :screen_shot, :bug_type, :bug_status, :project_id, :creator_id)
  end

  def find_bug
    @bug = Bug.find(params[:id])
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

  def authorize_bug_everytime
    authorize @bug
  end
end
