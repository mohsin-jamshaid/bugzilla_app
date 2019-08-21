class BugsController < ApplicationController
  before_action :find_bug, except: %i[index new create]
  before_action :find_project

  append_before_action :authorize_bug, except: %i[new index create]

  def index
    @bugs = @project.bugs.order('deadline')

    authorize @project, policy_class: BugPolicy
  end

  def new
    @bug = @project.bugs.build
    authorize_bug
  end

  def create
    @bug = @project.bugs.build(bug_params)

    authorize @bug

    if @bug.save
      flash[:success] = 'Bug has been successfully created'
      redirect_to project_bugs_path(@project)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @bug.update(bug_params)
      flash[:success] = 'Bug has been successfully updated'
      redirect_to project_bugs_path(@project)

    else
      render 'edit'
    end
  end

  def destroy
    if @bug.destroy
      flash[:success] = 'Bug has been successfully destroyed'
      redirect_to project_bugs_path(@project)
    else
      flash[:success] = 'Bug has not been successfully destroyed'
    end
  end

  def assign_bug
    if @bug.update(assign_to_id: current_user.id)
      @bug.set_bug_next_state! unless @bug.started?
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

  def authorize_bug
    authorize @bug
  end
end
