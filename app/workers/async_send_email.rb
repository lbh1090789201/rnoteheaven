class AsyncSendEmail
  include Sidekiq::Worker
  def perform(receiver, message)
    # demonstrate how to send an email asynchronously
    puts "first parameter:" + receiver.to_s
    puts "second parameter:" + message.to_s
    LyMailer.new_message(receiver, message).deliver
  end
end