class GroupUsersController < ApplicationController
  def create
    group = Group.find(params[:group_id])
    user = User.find(params[:post][:user_id])
    if group.group_users.find_by(user: user).blank?
      group.group_users.create(user: user)
      redirect_to edit_group_path(group)
    else
      redirect_to edit_group_path(group), notice: 'すでにグループに登録されています。'
    end
  end

  def destroy
    group = Group.find(params[:group_id])
    group_user = GroupUser.find(params[:id])
    if current_user == group_user.group.owner || current_user == group_user.user
      group_user.destroy
      redirect_to edit_group_path(group), notice: 'グループから離脱させました。'
    else
      redirect_to edit_group_path(group), notice: 'グループのオーナーもしくは本人のみ離脱させることができます。'
    end
  end

end
