APP_CONFIG = YAML.load_file(File.join(Rails.root, "config", "settings.yml"))[Rails.env].symbolize_keys