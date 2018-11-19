require_relative "ASTNode.rb"

class ASTList < ASTNode
  def to_s
    s = @token.type.to_s

    @children.each do |item|
      link = " ├── "

      if @children.last == item
        link = " └── "
      end

      # 递归 to_s
      s += "\n" + link + item.to_s
    end

    s
  end
end