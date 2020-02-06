class ApplicationMailer < ActionMailer::Base
  default from: "noreply@biblenota.com"
  layout "mailer"

  helper_method :link_to_frontend

  def link_to_frontend(text:, url: "")
    link = "https://#{Rails.configuration.frontend_host}/#{url}"
    view_context.link_to text, link
  end
end
