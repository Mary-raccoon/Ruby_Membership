class UsersController < ApplicationController
  def create
    @user = User.create(user_params)
    if !@user.valid?
      flash[:errors] = @user.errors.full_messages
      redirect_to "/"
    else
      session[:user_id] = @user.id
      flash[:success]="Welcome!!!"
      redirect_to "/groups/main"
    end
  end

  def main
    @user = User.find(current_user)
    @groups = Group.all
  end
  def create_group
    @group = Group.new(name: params[:name], desc: params[:desc], user_id: session[:user_id])
    if !@group.valid?
      flash[:errors] = @group.errors.full_messages
      redirect_to "/groups/main"
    else
      @group.save
      flash[:success]="New group was created!!!"
      redirect_to "/groups/main"
    end
  end

  def show
    @group = Group.find(params[:group_id])
  end

  def join
    @user = User.find(current_user_id)
    @group = Group.find(params[:group_id])
    @member = Member.new(user: @user, group: @group)
    @member.save
    redirect_to "/groups/#{params[:group_id]}"
  end
   
  def leave
    @group = Group.find(params[:group_id])
    @member = Member.find_by(group: @group, user: current_user)
    @member.destroy
    redirect_to "/groups/#{params[:group_id]}"
  end 

  def destroy
    @group = Group.find(params[:group_id])
    @group.destroy
    redirect_to "/groups/main"
  end

  private
  def  user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
