# frozen_string_literal: true

require "minitest/autorun"
require "vibes_client"

class VibesClientTest < Minitest::Test
  def test_english_hello
    assert_nil(VibesClient.hi("english"))
  end

  def test_any_hello
    assert_nil(VibesClient.hi("ruby"))
  end

  def test_spanish_hello
    assert_nil(VibesClient.hi("spanish"))
  end
end
