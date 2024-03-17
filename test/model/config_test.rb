# frozen_string_literal: true
require_relative 'test_helper'
require_relative "../../config"
require "securerandom"
class ConfigTest < Test
  describe "CastingConfigHelpers" do
    it "" do
      ENV["SUCH_BASE"] = SecureRandom.base64(64)
      bla = Class.new do
        extend CastingConfigHelpers

        override :thing, 1.234, float
        override :arr, "a,b,c,d", array(string)
        override :one_el, "a", array(string)
        override :zero_el, nil, array(string)
        override :such_int, 123, int
        override :quelle_symbol, :bla, symbol
        optional :such_base, base64, clear: true
      end

      assert_equal bla.thing, 1.234
      assert_equal bla.arr, ["a", "b", "c", "d"]
      assert_equal bla.one_el, ["a"]
      assert_nil bla.zero_el
      assert_equal bla.such_int, 123
      assert_equal bla.quelle_symbol, :bla
      refute_nil bla.such_base
    end

    it "production?" do
      refute Config.production?
    end
  end
end
