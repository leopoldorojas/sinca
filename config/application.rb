require File.expand_path('../boot', __FILE__)
require 'csv'

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Sinca
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Central America'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :es

    config.to_prepare do
      Devise::SessionsController.layout "sign_in_layout" 
      Devise::RegistrationsController.layout "sign_in_layout"
    end

    config.app_start_date = Date.new(2014, 10, 1)
    config.superadmin = "leopoldo.rojas@arckanto.com"
    config.individual_indicators = {
      indicator_1: "Saldo Bruto de Cartera de Préstamos",
      indicator_2: "Promedio del Saldo en Préstamos",
      indicator_3: "Cartera en Riesgo > 30 Días",
      indicator_4: "Cartera en Riesgo > 90 Días",
      indicator_5: "Prestatarios (Individuales)",
      indicator_6: "Préstamos Activos",
      indicator_7: "Porcentaje de Mujeres Prestatarias"
    }

    config.indicator_rules = {

      indicator_2: {
        operated_by: :divided_by,
        dividend: :indicator_1, 
        divisor: :indicator_6
      },

      indicator_3: {
        operated_by: :percentage,
        entire: :indicator_1
      },

      indicator_4: {
        operated_by: :percentage,
        entire: :indicator_1
      },

      indicator_7: {
        operated_by: :percentage,
        entire: :indicator_5
      },

    }

    config.user_roles = {
      superadmin: { privilege: 99 },
      admin: { privilege: 60 }, 
      analytic_executive: { privilege: 50 },
      executive: { privilege: 40 },
      analytic: { privilege: 30 },
      company_admin: { privilege: 20 },
      company_user: { privilege: 10 }
    }
  end
end
