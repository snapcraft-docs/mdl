require_relative 'setup_tests'
require 'json'
require 'pp'

class TestMiniJson < Minitest::Test
  include MarkdownLint
  def make_entry
    {
      "filename" => "somefile.md",
      "line" => 12,
      "rule" => "MD032",
      "aliases" => ["some alias"],
      "description" => "some description here"
    }
  end

  def test_mini_json_simple
    json_str = MiniJson.generate(make_entry)
    json = JSON.parse(json_str)
    assert_equal json, JSON.parse(JSON.generate(json))
  end

  def test_with_multiple_entries
    entries = [make_entry, make_entry, make_entry]
    entries_str = entries.map { |ent| MiniJson.generate(ent) }
    joined_entries = "[#{entries_str.join(',')}]"
    final = JSON.parse(joined_entries)
    assert_equal final, JSON.parse(JSON.generate(entries))
  end

  def test_with_wrong_keys_should_raise
    entry = make_entry.merge({"hahaha" => "oh no"})
    assert_raises do
      # TODO: might be better to have an exception type instead of
      # catch-all here
      MiniJson.generate(entry)
    end
  end

  def test_with_many_aliases
    entry = make_entry
    entry["aliases"] = (0..10).map { |e| "alias-#{e}" }
    json_str = MiniJson.generate(entry)
    assert_equal entry, JSON.parse(json_str)
  end
end
