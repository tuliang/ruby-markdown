class Token
  attr_accessor :type, :line_number, :text

  def initialize(type, line_number, text = nil)
    @type = type
    @line_number = line_number
    @text = text
  end
end