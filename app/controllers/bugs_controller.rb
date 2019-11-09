class BugsController < ApplicationController
  before_action :find_bug, except: %i[index new create]
  before_action :find_project

  append_before_action :authorize_bug, except: %i[new index create]

  def index
    @bugs = @project.bugs.order('deadline').with_attached_image

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
    @bug.destroy

    respond_to do |format|
      format.js { render layout: false }
      format.html { redirect_to project_bugs_path(@project) }
    end
  end

  def assign_bug
    if @bug.update(assign_to_id: current_user.id)
      @bug.set_bug_next_state! unless @bug.started?
      @msg = ['success', 'Bug has been successfully assigned']

    else
      @msg = ['error', 'Cannot take bug deadline already passed']
    end

    respond_to do |format|
      format.js { render layout: false }
      format.html { redirect_to project_bugs_path(@project) }
    end
  end

  def resolve_bug
    @msg = @bug.set_bug_next_state! ? ['success', 'Bug is successfully resolved'] : ['error', 'Cannot resolve bug you may have passed the deadline,wait for QA to edit the deadline']

    respond_to do |format|
      format.js { render 'assign_bug.js.erb', layout: false }
      format.html { redirect_to project_bugs_path(@project) }
    end
  end

  private

  def bug_params
    params.require(:bug).permit(:title, :deadline, :image, :bug_type, :bug_status, :creator_id)
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
