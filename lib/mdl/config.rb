require 'mixlib/config'

module MarkdownLint
  module Config
    extend Mixlib::Config

    config_strict_mode false
    default :style, "default"
  end
end
