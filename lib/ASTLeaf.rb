require_relative "ASTNode.rb"

class ASTLeaf < ASTNode
  def to_s
    @token.text
  end
end