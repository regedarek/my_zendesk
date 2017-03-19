# Represents a result of an operation. Use Failure/Success to make it more concise
# Its recommended to use named args:
# result = Failure.new(:invalid, foo: 'bar')
# result.invalid { |foo:| puts foo }
# result = Success.new(foo: 'bar')
# result.success { |foo:| puts foo }
# use result.else_fail! to catch all unhandled failures (success is never 'unhandled')

# use on! to make it even easier (will cann else_fail! at the end always)
# result.on!(
#   success: -> { puts 'success' }
#   invalid: -> { puts 'success' }
# )
#
# you can also do simple checks
# result = Failure.new(:coach_not_found)
# return render: nothing, status: 404 if result.coach_not_found?
# result.else_fail!
# [...] code that will run on success only [...]
#
# or use procs
# result = Failure.new(:coach_not_found)
# result.on!(
#   coach_not_found: -> { return render: nothing, status: 404 }
# )
# [...] code that will run on success only [...]
class Result
  attr_reader :name

  def initialize(name, *args)
    @name = name
    @args = args
    @was_called = false
    @was_checked = false

    define_singleton_method(name) do |&block|
      block.call(*@args)
      @was_called = true
    end

    define_singleton_method("#{name}?") do
      @was_checked = true
      true
    end
  end

  def fetch_arg(arg_name)
    @args.first.fetch(arg_name)
  end

  def else
    yield unless handled?
  end

  def handled?
    @was_called || @was_checked
  end

  def else_fail!
    self.else { fail "unhandled Result '#{@name}' with args: #{@args.inspect}" }
  end

  def method_missing(_method_name, *_args, &_block)
    false
  end

  def inspect
    "#{self.class.name}<#{@name}:#{@args.inspect}>"
  end

  def on!(callbacks)
    callbacks.each do |name, callback|
      send(name, &callback)
    end
    else_fail!
  end
end
