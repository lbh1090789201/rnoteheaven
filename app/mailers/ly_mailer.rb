class LyMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  def confirmation_instructions(record, token, opts={})
    headers["Custom-header"] = "Bar"
    opts[:from] = 'publicinfo@roadclouding.com'
    opts[:reply_to] = 'publicinfo@roadclouding.com'
    super
  end

  def new_message (receiver, message)
    @message = message
    mail(from: "publicinfo@roadclouding.com",
         to: receiver,
         message: message)
  end
end