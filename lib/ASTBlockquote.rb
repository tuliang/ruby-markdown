require_relative "ASTList.rb"

class ASTBlockquote < ASTList
  def body
    @children[0].token.text
  end

  def to_html
    "<blockquote><p>#{body}</p></blockquote>"
  end
end