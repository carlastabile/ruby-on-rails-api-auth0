module ApiHelpers
  def json
    JSON.parse(response.body)
  end
end

RSpec.configure do |c|
  c.include ApiHelpers
end