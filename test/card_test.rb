#!/usr/bin/env ruby

require_relative 'test_helper'

class TestCard < Minitest::Test

  def setup
    @card = Card.new("Test Card", "this is a test card")
  end

  def test_name
    assert_equal("Test Card", @card.name)
  end

  def test_desc
    assert_equal("this is a test card", @card.desc)
  end

end

