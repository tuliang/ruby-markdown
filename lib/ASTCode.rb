require_relative "ASTList.rb"

class ASTCode < ASTList
  def body
    @children.collect {|item| "<p>#{item.token.text}</p>"}.join
  end

  def to_html
    "<pre><code>#{body}</code></pre>"
  end
end