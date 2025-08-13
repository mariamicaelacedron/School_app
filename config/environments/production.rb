require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Configuraciones básicas
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false

  # Configuración de caché
  config.action_controller.perform_caching = true
  config.public_file_server.headers = { "cache-control" => "public, max-age=#{1.year.to_i}" }
  # config.cache_store = :solid_cache_store

  # Active Storage
  config.active_storage.service = :local

  # Seguridad SSL
  config.assume_ssl = true
  config.force_ssl = true

  config.active_storage.service = :amazon
  config.active_storage.service_urls_expire_in = nil
  config.active_storage.content_type_to_serve_as = 'public' 
  # Logging
  config.log_tags = [ :request_id ]
  config.logger = ActiveSupport::TaggedLogging.logger(STDOUT)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.silence_healthcheck_path = "/up"
  config.active_support.report_deprecations = false

  # Active Job
  # config.active_job.queue_adapter = :solid_queue
  # config.solid_queue.connects_to = { database: { writing: :queue } }

  # ===== CONFIGURACIÓN CORREGIDA PARA SENDGRID =====
  config.action_mailer.raise_delivery_errors = true # Para detectar fallos
  config.action_mailer.perform_deliveries = true # Activar envíos
  config.action_mailer.delivery_method = :smtp

  # Usa UNICAMENTE tu dominio de Heroku o personalizado
  config.action_mailer.default_url_options = {
    host: "alianza-inglesa-caed2cbd2d4b.herokuapp.com",
    protocol: "https"
  }

  config.action_mailer.smtp_settings = {
    address: "smtp.sendgrid.net",
    port: 587,
    domain: "alianza-inglesa-caed2cbd2d4b.herokuapp.com", # Mismo dominio que arriba
    user_name: "apikey", # Literalmente esta palabra
    password: ENV["SENDGRID_API_KEY"], # Variable que ya configuraste
    authentication: :plain,
    enable_starttls_auto: true
  }
  # ===== FIN DE CONFIGURACIÓN SENDGRID =====

  # Internacionalización
  config.i18n.fallbacks = true

  # Active Record
  config.active_record.dump_schema_after_migration = false
  config.active_record.attributes_for_inspect = [ :id ]

  # Opcional: Configuración de hosts permitidos (recomendado para seguridad)
  # config.hosts = [
  #   "school-app-alianza-921920d4b6e0.herokuapp.com"
  # ]
end
