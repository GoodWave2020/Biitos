class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  def index
    @group = Group.all
  end

  def new
    @group = Group.new
    @group.users << current_user
    @group.owner << current_user
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to groups_path, notice: 'グループを作成しました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path, notice: 'グループ情報を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path, notice: 'グループを削除しました。'
  end

  private
  def group_params
    params.require(:group).permit(:name, :description, user_ids: [])
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
