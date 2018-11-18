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
    if @children.length != 0
      s = @token.type

      @children.each do |item|
        s += "\n  "+item.to_s
      end

      s
    else
      @token.text + "\n\n"
    end
  end

  def to_html
    case @token.type
    when 'H1'
      "<h1>#{@children[0].token.text.lstrip}</h1>"
    when 'H2'
      "<h2>#{@children[0].token.text.lstrip}</h2>"
    when 'H3'
      "<h3>#{@children[0].token.text.lstrip}</h3>"
    when 'Text'
      "<p>#{@token.text}</p>"
    when 'Code'
      "<pre><code>#{@children[0].token.text}</code><pre>"
    else
      raise "bad token type at line #{@token.line_number}"
    end
  end
end