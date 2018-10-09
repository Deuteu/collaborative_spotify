# frozen_string_literal: true

module YamlEnvLoader
  class << self
    def call
      read_config(get_yaml('config', 'environment.yml')[Rails.env])
      read_config(get_yaml('config', 'environment_secret.yml')[Rails.env])
      read_config(get_yaml('config', 'environments', "#{Rails.env}.yml"))
    end

    private

    def get_yaml(*path)
      file = File.join(Rails.root, path)

      return {} unless File.exist?(file)

      log("#{file} loaded")
      YAML.safe_load(File.open(file), [], [], true) || {}
    end

    def read_config(env_config)
      return unless env_config.present?

      set_keys = env_config.each_with_object([]) do |(k, v), a|
        key = k.upcase
        ENV[key] = v
        a << key
      end
      log("#{set_keys.join(',')} set")
    end

    def log(text)
      puts "YamlEnvLoader >> #{text}"
    end
  end
end
