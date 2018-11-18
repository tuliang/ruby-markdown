class Parser
  attr_accessor :ast

  def initialize(queue)
    @queue = queue
    @ast = ast_runner
  end

  def ast_runner
    index = 0
    ast = []
    while @queue.length > index do
      token = @queue[index]

      case token.type
      when 'H1', 'H2', 'H3'
        # H1 H2 H3 规则
        # index 向后移动 1 位 并将节点附加到 children 末尾
        node = ASTList.new(token)

        index += 1
        node.children << ASTLeaf.new(@queue[index])
      when 'Text'
        # Text 规则 
        # 直接生成叶子节点
        node = ASTLeaf.new(token)
      when 'Code'
        # Code 规则 
        # index 向后移动 1 位 并将节点附加到 children 末尾
        node = ASTList.new(token)

        index += 1
        node.children << ASTLeaf.new(@queue[index])

        # index 再向后移动 1 位 因为当前节点为闭合节点 所以不做任何操作
        index += 1
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
    @ast.each do |item|
      item.to_s
    end
  end

  def to_html
    html = ''
    @ast.each do |item|
      html += item.to_html
    end

    html
  end
end