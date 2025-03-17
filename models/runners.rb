class Runners
  include Enumerable
  extend Forwardable
  def_delegators :@data, :size, :length, :[], :empty?, :last, :index

  def initialize(data)
    @data = data
  end

  [
    :confirmed,
    :maybe,
    :likely
  ].each do |state|
    define_method state do
      @data.select{|r| r.state.state == state }
    end
  end

  def find!(key) = @data.detect{|r| r.key == key } || raise("No one named #{key}")
  def by_slug(string) = @data.detect{|r| r.slugs.include?(string)}
  def each(&block) = @data.each(&block)
end
