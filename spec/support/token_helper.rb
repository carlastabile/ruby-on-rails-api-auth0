module TokenHelper
  def self.read_token(name)
    path = File.expand_path(File.join(File.dirname(__FILE__), '..', 'fixtures', name))
    File.read(path)
  end
end

RSpec.configure do |c|
  c.include TokenHelper
end