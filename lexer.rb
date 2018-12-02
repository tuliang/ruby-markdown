# 引入 lib 下所有 *.rb文件
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

class Lexer
  attr_accessor :filename, :regex, :queue

  RULES = [
    [:blockquote, "(^>)"],
    [:h6, "(^######)"],
    [:h5, "(^#####)"],
    [:h4, "(^####)"],
    [:h3, "(^###)"],
    [:h2, "(^##)"],
    [:h1, "(^#)"],
    [:code, "(^```)"],
    [:text, "(.+)"]
  ]

  RULE = RULES.collect {|k,v| v }.join('|')

  def initialize(filename)
    @filename = filename
    @regex = Regexp.new(RULE)
    @queue = []

    read
  end

  def parser
    Parser.new(@queue)
  end

  def read
    File.readlines(@filename).each_with_index do |line, i|
      # i 从 0 开始 需要先 + 1
      @line_number = i + 1

      readline(line)
    end
  end

  private

  def readline(line)
    array_list = line.scan(@regex)

    if array_list.length != 0
      array_list.each do |array|
        add_token(array)
      end
    else
      # 空行
    end
  end

  def add_token(array)
    token = Token.new

    array.each_with_index do |item, index|
      if item != nil
        token.type = RULES[index][0]
        token.line_number = @line_number

        if token.type == :text
          token.text = item 
        end

        # 找到单词 退出循环
        break
      end
    end

    if token.type.nil?
      raise "bad token at line #{@line_number}"
    end

    @queue << token
  end
end

# 读取文件 生成单词序列
lexer = Lexer.new("README.md")
# 读取单词序列 生成 AST
parser = lexer.parser
# 显示 AST
parser.show
# 转换为 HTML
puts parser.to_html