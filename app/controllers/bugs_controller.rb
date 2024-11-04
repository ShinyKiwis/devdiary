# frozen_string_literal: true

class BugsController < ApplicationController
  def index
    @bugs = Bug.all
  end

  def new
    @bug = Bug.new
    @bug.build_environment
  end

  def create
    @bug = Bug.new(bug_params)

    if @bug.save
      flash[:footer_modal] = { type: 'success', title: 'New bug on track!', message: 'Your bug has been successfully created.' }
      redirect_to bug_path(@bug), status: 303
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @bug = Bug.find(params[:id])
  end

  def edit
  end

  def destroy
    @bug = Bug.find(params[:id])
    @bug.destroy

    flash[:footer_modal] = { type: 'success', title: 'Bug squashed!', message: 'Your bug has been successfully deleted.' }
    redirect_to bugs_path, status: 303
  end

  private

  def bug_params
    params.require(:bug).permit(
      :title,
      :difficulty_level,
      :description,
      :context,
      environment_attributes: [
        :operating_system,
        :language,
        :language_version,
        :framework,
        :framework_version,
        :database,
        :database_version,
        :browser,
        :browser_version,
        :additional_context,
      ],
    )
  end
end
