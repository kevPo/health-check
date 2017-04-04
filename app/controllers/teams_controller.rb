class TeamsController < ApplicationController
  def show
    @team = Team.find(params[:id])
  end

  def index
    @teams = current_user.teams
    respond_to do |format|
      format.html
      format.json { render :json => @teams }
    end
  end

  def select
    @teams = current_user.teams
    respond_to do |format|
      format.html
      format.json { render :json => @teams }
    end
  end

  def selected
    team = Team.find(params[:id])
    select_team team
    redirect_to root_url
  end

  def destroy
    Team.find(params[:id]).destroy
    flash[:success] = "Team deleted."
    redirect_to teams_url
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      flash[:success] = "your team was created"
      current_user.memberships.create(:team_id => @team.id)
      redirect_to @team
    else
      render 'new'
    end
  end

private

  def team_params
    params.require(:team).permit(:name)
  end

end
