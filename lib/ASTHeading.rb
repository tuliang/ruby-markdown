require_relative "ASTList.rb"

class ASTHeading < ASTList

  def to_html
    tag = @token.type.downcase

    "<#{tag}>#{@children[0].token.text}</#{tag}>"
  end
end