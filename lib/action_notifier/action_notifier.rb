require "abstract_controller"

module ActionNotifier
  class Error < StandardError; end

  class << self
    def respond_to?(method, include_private = false)
      super || action_methods.include?(method.to_s)
    end

    protected

    def method_missing(method_name, *args)
      if respond_to?(method_name)
        new.send(method_name, *args)
      else
        super
      end
    end
  end

  def notify(application, device_token, message, custom = {})
    if application.is_a? Rpush::Apns::App
      notification = :notify_apple_push_notification_service
    elsif application.is_a? Rpush::Gcm::App
      notification = :notify_firebase_cloud_messaging
    elsif application.is_a? Rpush::Adm::App
      notification = :notify_amazon_device_messaging
    elsif application.is_a? Rpush::Pushy::App
      notification = :notify_pushy
    else
      raise ArgumentError, "Unsupported application"
    end

    return send notification, application, device_token, message, custom
  end

  def notify_apple_push_notification_service(application, device_token, message, custom = {})
    notification = Rpush::Apns::Notification.new
    notification.app = application
    notification.device_token = device_token
    notification.alert = message.truncate(110)
    if custom[:badge]
      notification.badge = custom.delete(:badge)
    end
    notification.sound = custom.delete(:sound) || 'default'
    notification.data = custom
    notification.save!
    return notification
  end

  def notify_firebase_cloud_messaging(device_token, message, custom = {})
    notification = Rpush::Gcm::Notification.new
    notification.app = Rpush::Gcm::App.find_by_name("android_app")
    notification.registration_ids = [device_token]
    notification.data = { message: message }.merge(custom)
    notification.save!
    return notification
  end

  def notify_amazon_device_messaging(device_token, message, custom = {})
    notification = Rpush::Adm::Notification.new
    notification.app = Rpush::Adm::App.find_by_name("kindle_app")
    notification.registration_ids = [device_token]
    notification.data = { message: message }.merge(custom)
    notification.save!
    return notification
  end

  def notify_pushy(device_token, message, custom = {})
    notification = Rpush::Pushy::Notification.new
    notification.app = Rpush::Pushy::App.find_by_name("android_app")
    notification.registration_ids = [device_token]
    notification.data = { message: message }.merge(custom)
    notification.time_to_live = 60
    notification.save!
    return notification
  end
end