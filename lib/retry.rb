# This class help to retry a piece of code that could raise an exception.
class Retry
  DEFAULT_RETRIES_TIME = 3
  DEFAULT_WAITING_TIME = 0

  attr_reader :exception_classes, :times

  # Execute the block in a retry context.
  # @param exception_classes [Array<Error>] the exceptions to retry
  # @param times [Integer] number of retries before raise the exception
  # @param waiting_time [Integer, Float] delay in seconds before retrying ; for millis, use a float value
  def self.on(*exception_classes, times: DEFAULT_RETRIES_TIME, waiting_time: DEFAULT_WAITING_TIME, &block)
    new(exception_classes, times: times, waiting_time: waiting_time).run(&block)
  end

  # @param exception_classes [Array<Error>] the exceptions to retry
  # @param times [Integer] number of retries before raise the exception
  # @param waiting_time [Integer, Float] delay in seconds before retrying ; for millis, use a float value
  def initialize(exception_classes, times:, waiting_time:)
    @exception_classes = Array(exception_classes)
    @times = times
    @waiting_time = waiting_time
  end

  # Execute the block in a retry context
  def run
    retries ||= 0
    yield retries
  rescue *exception_classes
    retries += 1

    raise if retries >= times

    sleep(waiting_time(retries))

    retry
  end

  private

  def waiting_time(retries)
    retries * retries * @waiting_time * random_offset
  end

  def random_offset
    0.9 + (rand * 0.2)
  end
end
