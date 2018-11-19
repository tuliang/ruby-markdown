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
    ""
  end
end