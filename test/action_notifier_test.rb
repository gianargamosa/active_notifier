require "test_helper"
require "rpush"
require "action_notifier"

class TestNotifier < ActionNotifier::Base
  def test_notification(application, device_token, message = MESSAGE, custom = {})
    notify(application, device_token, message, custom)
  end
end

class ActionNotifierTest < Minitest::Test
  MESSAGE = "This is a test message"

  def test_that_it_has_a_version_number
    refute_nil ::ActionNotifier::VERSION
  end

  def setup
    @apple_notification_service_app = Rpush::Apns::App.first
    @apple_notification_service_token = 'apple_notification_service_token'
    @firebase_cloud_notification_app = Rpush::Gcm::App.first
    @firebase_cloud_notification_token = 'firebase_cloud_notification_token'
  end

  def test_notifier_methods_can_be_called_on_instances
    notifier = TestNotifier.new
    notifier.expects(:sample_notification).with(@apple_notification_service_app, @firebase_cloud_notification_app)
    notifier.test_notification(@apple_notification_service_token, @firebase_cloud_notification_token)
  end

  def test_notifier_methods_can_be_called_on_classes
    TestNotifier.any_instance.expects(:sample_notification).with(@apple_notification_service_app, @firebase_cloud_notification_app)
    TestNotifier.sample_notification(@apple_notification_service_token, @firebase_cloud_notification_token)
  end

  def test_push_apns_calls_correct_method
    TestNotifier.any_instance.expects(:notify_apple_push_notification_service).with(@apple_notification_service_app, @firebase_cloud_notification_app, ActionNotifierTest::MESSAGE, {})
    TestNotifier.sample_notification(@apple_notification_service_token, @firebase_cloud_notification_token)
  end
end
