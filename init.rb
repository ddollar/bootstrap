Dir[File.join(File.dirname(__FILE__), 'ext', '**', '*.rb')].each do |file|
  require file
end

Dir[File.join(File.dirname(__FILE__), 'lib', '**', '*.rb')].each do |file|
  require file
end
