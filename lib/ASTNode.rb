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
        link = " ├── "

        if @children.last == item
          link = " └── "
        end

        s += "\n" + link + item.to_s
      end

      s
    else
      @token.text
    end
  end

  def to_html
    case @token.type
    when 'H1'
      "<h1>#{@children[0].token.text}</h1>"
    when 'H2'
      "<h2>#{@children[0].token.text}</h2>"
    when 'H3'
      "<h3>#{@children[0].token.text}</h3>"
    when 'Text'
      "<p>#{@token.text}</p>"
    when 'Code'
      "<pre><code>#{@children.collect {|item| "<p>#{item.token.text}</p>"}.join }</code><pre>"
    else
      raise "bad token type at line #{@token.line_number}"
    end
  end
end