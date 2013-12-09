class AppointmentsController < ApplicationController

def index
  date_from_ajax = params[:matched_date]
  reduce = Appointment.where(:date => date_from_ajax)
  hour_on_date = reduce.collect {|x| x.hour}
  @new_dates = hour_on_date
  render :layout => false
end

def new
  @appointments = Appointment.new
    respond_to do |format|
      format.html
      format.js
      end
   end
 

def create
  @exchanges = Exchange.all
   @appointment = Appointment.new(appointment_params)
    if @appointment.save
      redirect_to new_appointment_path
    else
      err = ''
      @appointment.errors.full_messages.each do |m|
      err << m
    end

      redirect_to new_appointment_path, :flash => { :alert => "#{err}, please try again" }
    end
  end

private

  def appointment_params
    params.require(:appointment).permit(:date, :hour)
  end


end

