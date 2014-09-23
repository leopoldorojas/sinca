require File.expand_path('../boot', __FILE__)

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

    config.app_start_date = Date.new(2013, 8, 1)
    config.individual_indicators = {
      indicator_1: "Saldo Bruto de Cartera de Préstamos",
      indicator_2: "Cartera en Riesgo > 90 Días",
      indicator_3: "Clientes Activos",
      indicator_4: "Porcentaje de Mujeres Prestatarias",
      indicator_5: "Promedio del Saldo en Préstamos",
      indicator_6: "Total Desembolsado (Préstamos Activos)",
      indicator_7: "Créditos Desembolsados (total histórico)"
    }
  end
end
