require_relative "ASTList.rb"

class ASTUl < ASTList
  def body
    @children.collect {|item| "<li>#{item.token.text}</li>"}.join
  end

  def to_html
    "<ul>#{body}</ul>"
  end
end