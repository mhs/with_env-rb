require "spec_helper"

describe WithEnv do
  subject(:helper){ Object.new.tap{ |o| o.extend WithEnv }}

  it "has a version number" do
    expect(WithEnv::VERSION).not_to be nil
  end

  describe "#with_env" do
    it "makes the given ENV variables available during block execution" do
      helper.with_env "FOO" => "1", "BAR" => "baz" do
        expect(ENV["FOO"]).to eq("1")
        expect(ENV["BAR"]).to eq("baz")
      end
    end

    it "resets the ENV back to what it was after block execution" do
      before = ENV.to_h.dup
      helper.with_env("FOO" => "1", "BAR" => "baz"){ }
      expect(ENV.to_h).to eq(before)
    end
  end
end
