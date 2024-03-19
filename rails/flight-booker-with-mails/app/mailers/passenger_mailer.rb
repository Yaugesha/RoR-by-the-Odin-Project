class PassengerMailer < ApplicationMailer
  def confirmation_email
    @user = params[:user]
    @booking = params[:booking]
    @url = "http://localhost:3000/bookings/#{@booking.id}/confirm"
    mail(to: @user.email, subject: "Confirmation booing flight tickets")
  end
end
