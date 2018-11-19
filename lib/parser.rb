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
      when 'H1', 'H2', 'H3'
        # H1 H2 H3 规则
        node = ASTHeading.new(token)

        # index 向后移动 1 位 指向下个节点 
        index += 1
        next_node = @queue[index]
        # 去除左边的空格
        next_node.text.lstrip!
        # 将节点附加到 children 末尾
        node.children << ASTLeaf.new(next_node)
      when 'Text'
        # Text 规则 
        # 直接生成叶子节点
        node = ASTText.new(token)
      when 'Code'
        # Code 规则 
        
        node = ASTCode.new(token)

        # Code 未闭合前一直循环
        while true do
          # index 向后移动 1 位 指向下个节点 
          index += 1
          next_node = @queue[index]
          
          if next_node.type == 'Code'
            # 当前节点为闭合节点 退出循环
            break
          else
            # 将节点附加到 children 末尾
            node.children << ASTLeaf.new(next_node)
          end
        end
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