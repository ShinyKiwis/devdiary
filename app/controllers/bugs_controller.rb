# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :find_object, only: %i[show edit update destroy resolving investigate resolve close]
  def index
    @bugs = Bug.page(params[:page]).per(Settings[:kaminari][:per_page])
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

  def resolving
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
    @bug.assign_attributes(bug_params.except(:attachments))
    ActiveRecord::Base.transaction do
      if @bug.try_resolve! || @bug.save
        @bug.attachments.purge
        @bug.attachments.attach(bug_params[:attachments]) if bug_params[:attachments].present?
      end
    end

    flash[:footer_modal] = { type: 'success', title: 'Bug solution updated!', message: 'Your solution has been updated. Good job!' }
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
      :solution,
      :explanation,
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
      attachments: [],
    )
  end

  def find_object
    @bug ||= Bug.find(params[:id])
  end
end
