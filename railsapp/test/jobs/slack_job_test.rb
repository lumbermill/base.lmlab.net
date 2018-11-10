require 'test_helper'

class SlackJobTest < ActiveJob::TestCase
  test "the truth" do
    assert_nil SlackJob.perform_now "Good morning"
  end
end
