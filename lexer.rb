# 引入 lib 下所有 *.rb文件
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

class Lexer
  attr_accessor :filename, :regex, :queue

  def initialize(filename)
    @filename = filename
    @regex = /(^###)|(^##)|(^#)|(^```)|(.+)/
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
    array = line.scan(@regex)

    if array.length != 0
      array.each do |item|
        add_token(item)
      end
    else
      # 空行
    end
  end

  def add_token(item)
    if item[0] != nil
      token = Token.new('H3', @line_number)
    elsif item[1] != nil
      token = Token.new('H2', @line_number)
    elsif item[2] != nil
      token = Token.new('H1', @line_number)
    elsif item[3] != nil
      token = Token.new('Code', @line_number)
    elsif item[4] != nil
      token = Token.new('Text', @line_number, item[4])
    else
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
puts parser.show
# 转换为 HTML
puts parser.to_html