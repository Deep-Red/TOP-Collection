class PassengerMailer < ApplicationMailer

  def booking_confirmation_email(passenger, booking)
    @booking = booking
    @passenger = passenger
    @url = 'http://localhost:3000'
    mail(to: @passenger.email, subject: 'Thank you for booking a flight')
  end

end
