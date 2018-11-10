class SlackJob < ApplicationJob
  queue_as :default

  def perform(*args)
    SlackJob.slack_ping(args[0])
  end

  def self.slack_init
    return if Rails.env.test?
    url = ENV["BASE_SLACK_WEBHOOK_URL"]
    return if url.blank?
    notifier = Slack::Notifier.new(url)
    yield(notifier)
  end

  def self.slack_ping(msg="Hello, world!")
    slack_init do |notifier|
      notifier.ping(msg)
    end
  end
end
