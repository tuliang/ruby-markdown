require_relative "ASTList.rb"

class ASTCode < ASTList
  def to_html
    "<pre><code>#{@children.collect {|item| "<p>#{item.token.text}</p>"}.join }</code><pre>"
  end
end