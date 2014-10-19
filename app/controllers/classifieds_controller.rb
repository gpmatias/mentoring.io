class ClassifiedsController < ApplicationController

  before_filter :set_member, only: [:new, :create, :preview, :edit, :update, :confirm]
  before_filter :set_classified, only: [:edit, :update]
  
  def index
    @classifieds = Classified.where(preview: false)
  end

  def new
    @skills = Skill.all
    @classified = @member.classifieds.build
  end

  def create
    @classified = @member.classifieds.create!(classified_params)

    redirect_to classified_preview_path(@classified.id), notice: "Your classified has been created"
  end

  def confirm
    @classified = @member.classifieds.find(params[:classified_id])
    @classified.update_attribute :preview, false

    redirect_to dashboard_index_path, notice: "Your classified has been listed"
  end

  def preview
    @classified = @member.classifieds.find(params[:classified_id])
  end

  def edit
  end

  def update
    @classified.update(classified_params)

    redirect_to classified_preview_path(@classified.id), notice: "Your classified has been updated"
  end

  private

  def set_member
    @member = current_member
  end

  def set_classified
    @classified = @member.classifieds.find(params[:id])
  end

  def classified_params
    params.require(:classified).permit(:description, :remote, :face_to_face, :preview, skill_ids: [])
  end
end
