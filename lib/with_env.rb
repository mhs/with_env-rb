require "with_env/version"

module WithEnv
  extend self

  def with_env(env, &blk)
    before = env.inject({}) { |h, (k, _)| h[k] = ENV[k]; h }
    env.each { |k, v| ENV[k] = v }
    yield
  ensure
    before.each { |k, v| ENV[k] = v }
  end
end
