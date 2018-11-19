require_relative "ASTLeaf.rb"

class ASTText < ASTLeaf
  def to_html
    "<p>#{@token.text}</p>"
  end
end