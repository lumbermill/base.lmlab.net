module ApplicationHelper
  def self.slack_init
    # return if Rails.env.test?
    url = 'https://hooks.slack.com/services/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'
    notifier = Slack::Notifier.new(url)
    yield(notifier)
  end

  def self.slack_ping(msg="Hello, world!")
    slack_init do |notifier|
      notifier.ping(msg)
    end
  end
end
