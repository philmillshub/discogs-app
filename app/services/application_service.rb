class ApplicationService
  def self.call(*args)
    new(*args).call
  end

  def initialize(*args)
    @args = args
  end

  private

  attr_reader :args
end 