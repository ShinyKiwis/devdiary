# frozen_string_literal: true

class Environment < ApplicationRecord
  FRAMEWORKS = {
    ruby: %w[rails],
    javascript: %w[react vue],
    python: %w[django flask],
    java: %w[spring],
    csharp: %w[dotnet],
    css: %w[bootstrap tailwind vanilla],
  }
  belongs_to :bug

  enum operating_system: {
    windows: 'windows',
    macos: 'macos',
    linux: 'linux',
    android: 'android',
    ios: 'ios',
  }

  enum language: {
    ruby: 'ruby',
    javascript: 'javascript',
    python: 'python',
    java: 'java',
    csharp: 'csharp',
    css: 'css',
  }

  enum database: {
    postgresql: 'postgresql',
    mysql: 'mysql',
  }

  enum browser: {
    firefox: 'firefox',
    chrome: 'chrome',
    safari: 'safari',
  }
end
