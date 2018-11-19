class ASTNode
  attr_accessor :token, :children

  def initialize(token)
    @token = token
    @children = []
  end

  def location
    "at line #{@token.line_number}"
  end

  def to_s
    ""
  end

  def to_html
    ""
  end
end