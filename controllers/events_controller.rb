class EventsController < ApplicationController

  before_action :set_event, :only => [ :show, :edit, :update, :destroy]

  def index
    @events = Event.page(params[:page]).per(5)
  end
  
  def new
    @event = Event.new
  end

  def show
    @page_title = @event.name
  end

  def create
    @event = Event.new(event_params)

    flash[:notice] = "event was successfully created"
    
    if @event.save
      redirect_to :action => :index   
    else
      render :action => :new 
    end
  end
  
  def edit
  end

  def destroy
    @event.destroy

    flash[:alert] = "event was successfully deleted"

    redirect_to :action => :index
  end
  
  def update
    @event.update(event_params)

    flash[:notice] = "event was successfully updated"

    redirect_to :action => :show, :id => @event
  end


  private

  def event_params
    params.require(:event).permit(:name, :description)
  end

  def set_event
    @event = Event.find(params[:id])
  end

end
