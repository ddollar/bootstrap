class Bootstrap::Manager

  @initializers = {}

  def self.load
    common_initializers = Dir[File.join(Bootstrap::ROOT_DIR, '*.rb')]
    env_initializers    = Dir[File.join(Bootstrap::ROOT_DIR, Rails.env, '*.rb')]

    @initializers.clear
    (common_initializers + env_initializers).each do |filename|
      identifier = File.basename(filename, File.extname(filename)).intern
      @initializers[identifier] = Bootstrap::Initializer.new(filename, identifier)
    end
  end

  def self.execute(identifier)
    raise "Unknown initializer: #{identifier}" unless @initializers.keys.include?(identifier)
    @initializers[identifier].execute
  end

  def self.execute_all
    @initializers.keys.each { |identifier| self.execute(identifier) }
  end

end
