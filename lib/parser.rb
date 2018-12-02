class Parser
  attr_accessor :ast

  def initialize(queue)
    @queue = queue
    @ast = ast_runner
  end

  def ast_runner
    index = 0
    ast = []

    # 遍历队列
    while @queue.length > index do
      token = @queue[index]

      case token.type
      when :h1, :h2, :h3, :h4, :h5, :h6
        node = ASTHeading.new(token)

        # index 向后移动 1 位 指向下个节点 
        index += 1
        next_node = @queue[index]
        # 去除左边的空格
        next_node.text.lstrip!
        # 将节点附加到 children 末尾
        node.children << ASTLeaf.new(next_node)
      when :text
        node = ASTText.new(token)
      when :code
        node = ASTCode.new(token)

        # 未闭合前一直循环
        while true do
          # index 向后移动 1 位 指向下个节点 
          index += 1
          next_node = @queue[index]
          
          if next_node.type == :code
            # 当前节点为闭合节点 退出循环
            break
          else
            # 将节点附加到 children 末尾
            node.children << ASTLeaf.new(next_node)
          end
        end
      when :blockquote
        node = ASTBlockquote.new(token)

        # index 向后移动 1 位 指向下个节点 
        index += 1
        next_node = @queue[index]
        # 去除左边的空格
        next_node.text.lstrip!
        # 将节点附加到 children 末尾
        node.children << ASTLeaf.new(next_node)
      else
        raise "bad token type at line #{token.line_number}"
      end

      # 将节点附加到 ast 末尾
      ast << node

      # index 向后移动 1 位 进行下个迭代
      index += 1
    end

    ast
  end

  def show
    @ast.each do |node|
      puts node
      puts "\n"
    end
  end

  def to_html
    @ast.collect {|node| node.to_html }.join
  end
end