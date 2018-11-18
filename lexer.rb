require "./library/token.rb"

class Lexer
  attr_accessor :filename, :regex, :queue

  def initialize(filename)
    @filename = filename
    @regex = /(^##)|(^#)|(^```)|(.+)/
    @queue = []

    read
  end

  def read
    File.readlines(@filename).each_with_index do |line, i|
      # i 从 0 开始 需要先 + 1
      @line_number = i + 1

      readline(line)
    end

    @queue.each do |item|
      p item
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
      token = Token.new('H2', @line_number)
    elsif item[1] != nil
      token = Token.new('H1', @line_number)
    elsif item[2] != nil
      token = Token.new('Code', @line_number)
    elsif item[3] != nil
      token = Token.new('Text', @line_number, item[3])
    else
      raise "bad token at line #{@line_number}"
    end

    @queue << token
  end
end

Lexer.new("README.md")