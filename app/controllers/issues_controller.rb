class IssuesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :delete]

  def index
    @issues = Issue.all
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = current_user.issues.create(issue_params)
    if @issue.valid?
      redirect_to new_issue_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @issue = Issue.find(params[:id])
  end

  def edit
    @issue = Issue.find(params[:id])
    if @issue.user != current_user
      return render plain: 'Not Allowed', status: :forbidden
    end
  end

  def update
    @issue = Issue.find(params[:id])
    if @issue.user != current_user
      return render plain: 'Not Allowed', status: :forbidden
    end

    @issue.update_attributes(issue_params)
    if @issue.valid?
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @issue = Issue.find(params[:id])
    if @issue.user != current_user
      return render plain: 'Not Allowed', status: :forbidden
    end
    
    @issue.destroy
    redirect_to root_path
  end

  private

  def issue_params
    params.require(:issue).permit(:name, :decription, :cost)
  end
end
