namespace :reminder_email do
  desc "Send email to everyone after 3 months of waiting"
  task :send_reminder do
    requests_confirmed = Request.where(status: "confirmed")
    requests_confirmed.each do |request|
      deadline = request.last_check + 3.months
      UserMailer.reminder(request.user).deliver_now if (Date.today > deadline)
    end
  end
end
