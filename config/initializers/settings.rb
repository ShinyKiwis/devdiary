# frozen_string_literal: true

require 'yaml'

Settings = YAML.load_file(Rails.root.join('config/settings.yml')).deep_symbolize_keys
