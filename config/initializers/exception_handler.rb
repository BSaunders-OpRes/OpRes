if Rails.env.development?
  Rails.application.config.exception_handler = {
    dev:        true,
    exceptions: {
      all: { layout: 'exception' }
    }
  }
end
