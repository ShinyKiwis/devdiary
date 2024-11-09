# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :find_object, only: %i[show edit update destroy investigate resolve close]
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
  end

  def edit
  end

  def update
    if @bug.update(bug_params)
      flash[:footer_modal] = { type: 'success', title: 'Bug updated!', message: 'Your bug has been successfully updated.' }
      redirect_to bug_path(@bug), status: 303
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bug.destroy

    flash[:footer_modal] = { type: 'success', title: 'Bug squashed!', message: 'Your bug has been successfully deleted.' }
    redirect_to bugs_path, status: 303
  end

  def investigate
    @bug.start!

    flash[:footer_modal] = { type: 'success', title: 'Investigation started!', message: 'Your bug is now under investigation. Good luck!' }
    redirect_to bug_path(@bug), status: 303
  end

  def resolve
    @bug.resolve!

    flash[:footer_modal] = { type: 'success', title: 'Bug resolved!', message: 'Your bug has been successfully resolved. Good job!' }
    redirect_to bug_path(@bug), status: 303
  end

  def close
    @bug.close!

    flash[:footer_modal] = { type: 'success', title: 'Bug closed!', message: 'Your bug has been successfully closed.' }
    redirect_to bug_path(@bug), status: 303
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

  def find_object
    @bug ||= Bug.find(params[:id])
  end
end
