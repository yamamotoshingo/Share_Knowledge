require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ShareKnowledge
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.yml').to_s]

    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      if instance.kind_of?(ActionView::Helpers::Tags::Label)
        # skip when label
        html_tag.html_safe
      elsif instance.kind_of?(ActionView::Helpers::Tags::Select)
        class_name = instance.object.class.name.underscore
        method_name = instance.instance_variable_get(:@method_name)
        "<span class=\"has-error\">#{html_tag}</span>
        <div class=\"help-block\">
          #{I18n.t("activerecord.attributes.#{class_name}.#{method_name}")}
          #{instance.error_message.first}
        </div>".html_safe
      else
        class_name = instance.object.class.name.underscore
        method_name = instance.instance_variable_get(:@method_name)
        "<div class=\"has-error\">#{html_tag}</div>
        <span class=\"help-block\">
          #{I18n.t("activerecord.attributes.#{class_name}.#{method_name}")}
          #{instance.error_message.first}
        </span>".html_safe
      end
    end
  end
end
