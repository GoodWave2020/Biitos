class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  def index
    @group = Group.all
  end

  def new
    @users = email_search(params[:search])
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner = current_user
    @group.users << current_user
    if @group.save
      redirect_to groups_path, notice: 'グループを作成しました。'
    else
      render :new
    end
  end

  def edit
    check_owner(@group)
    @users = email_search(params[:search])
  end

  def update
    check_owner(@group)
    if @group.update(group_params)
      redirect_to groups_path, notice: 'グループ情報を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    check_owner(@group)
    @group.destroy
    redirect_to groups_path, notice: 'グループを削除しました。'
  end

  private
  def group_params
    params.require(:group).permit(:name, :description)
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def check_owner(group)
    if current_user != group.owner
      redirect_to groups_path, notice: 'オーナー権限が必要です。'
    end
  end
end
