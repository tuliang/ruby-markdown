require_relative "ASTList.rb"

class ASTHeading < ASTList
  def body
    @children[0].token.text
  end

  def to_html
    tag = @token.type

    "<#{tag}>#{body}</#{tag}>"
  end
end