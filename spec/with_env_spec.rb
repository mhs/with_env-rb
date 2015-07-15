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

    it "restores the ENV back to what it was after block execution" do
      before = ENV.to_h.dup
      helper.with_env("FOO" => "1", "BAR" => "baz"){ }
      expect(ENV.to_h).to eq(before)
    end
  end

  describe "#without_env" do
    before { ENV["FOO"] = "1"; ENV["BAR"] = "2" }
    after  { ENV.delete("FOO"); ENV.delete("BAR") }

    it "removes the given env variables from ENV during block execution" do
      helper.without_env("FOFOOBARBAZO") do
        expect(ENV).to_not have_key("FOOBARBAZ")
      end
    end

    it "restores the ENV back to what it was after block execution" do
      before = ENV.to_h.dup
      helper.without_env("FOFOOBARBAZ") do
        expect(ENV).to_not have_key("FOOBARBAZ")
      end
      expect(ENV.to_h).to eq(before)
    end
  end
end
