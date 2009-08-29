class Bootstrap::Initializer

  attr_reader :filename, :executed

  def initialize(filename, identifier)
    @filename   = filename
    @identifier = identifier
    @executed   = false
  end

  def execute
    unless executed
      File.open(@filename, 'r') do |file|
        eval file.read
      end
      @executed = true
    end
  end

  def depends_on(*identifiers)
    identifiers.each do |identifier|
      Bootstrap::Manager.execute(identifier)
    end
  end

end
