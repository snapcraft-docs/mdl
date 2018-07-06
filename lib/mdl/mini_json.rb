module MarkdownLint
  # The reason this exists is to remove dependencies from alpine linux
  # builds.
  #
  # ref: https://github.com/markdownlint/markdownlint/issues/223
  #
  # This is strictly here for _simple and specific_ json generation for
  # the command line. This should not be extended to something too
  # complex. If for any reason in the future something more complex is
  # required, probably re-require 'json'.
  class MiniJson
    ExpectedKeys = ["filename", "line", "rule", "aliases", "description"].freeze

    def self.generate(result)
      if (result.keys - ExpectedKeys).size != 0
        raise "you need to provide the expected keys: #{ExpectedKeys}"
      end
      filename = '"filename": "%s"' % result["filename"]
      line = '"line": %d' % result["line"]
      rule = '"rule": "%s"' % result["rule"]
      aliases = '"aliases": [%s]' % result["aliases"].map { |e| "\"#{e}\"" }.join(',')
      description = '"description": "%s"' % result["description"]

      ret = [
        filename, line, rule,
        aliases, description].join(',')

      "{#{ret}}"
    end
  end
end
