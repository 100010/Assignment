class UsersController < ApplicationController

  layout 'user', except: [:new]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :confirm_valid_email, only: [:create]
  before_action :dont_approve_yourself!, only: [:approve_skill]

  def add_skill
  end

  def people
  end

  def approve_skill
    unless limit_skill_approve_count!(current_user.id, params[:skill_id])
      approved_skill = ActsAsTaggableOn::Tag.find params[:skill_id]
      approved_skill.approve_count += 1
      approved_skill.approved_user_id.push(current_user.id)
      approved_skill.approved_user_image.push(params[:image_url])
      approved_skill.save
      redirect_to :back
    end
  end

  def skills
    query = params[:q]
    @skills = User.skill_counts.where("name like ?", "%#{query}%")
    if @skills.empty?
      render json: [{ id: "#{query}", name: "New: \"#{query}\"", taggings_count: 0 }]
    else
      render json: @skills.map{|t| {id: t.name, name: t.name, taggings_count: t.taggings_count}}
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new permit_params
    if @user.save
      log_in @user
      remember @user
      redirect_to user_path @user, flash: {success: 'アカウント登録が完了しました'}
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update permit_params
      redirect_to user_path @user
    else
      render :edit
    end
  end

  private def set_user
    @user = User.find params[:id]
  end

  private def permit_params
    params[:user][:skill_list] = params[:user][:skill_list].split(',') if params[:user][:skill_list]
    params.
      require(:user).
        permit(
          :name,
          :email,
          :password,
          :password_confirmation,
          :image,
          :name,
          skill_list: []
        )
  end

  #email アドレスのフィルター
  private def confirm_valid_email
    if User.find_by email: params[:user][:email]
      redirect_to new_user_path, flash: { danger: "既に使われているemailです" }
    end
  end

  # 2回以上スキルをプラスしようとした時のためのフィルター
  private def limit_skill_approve_count!(user_id, skill_id)
    if ActsAsTaggableOn::Tag.find(params[:skill_id]).approved_user_id.include?(user_id.to_s)
      redirect_to :back, flash: { danger: "人のスキルは1回までしかプラスできません" }
    else
      return nil
    end
  end

  #自分自身を評価できない
  private def dont_approve_yourself!
    if params[:id] == current_user.id.to_s
      redirect_to :back, flash: { danger: "自分を評価できません" }
    end
  end

end
