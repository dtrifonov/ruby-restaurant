require 'singleton'
require 'io/console'

class AppDialog
  include Singleton
  attr_reader :question, :options, :answer

  def handle(question, options, password=false)
    @question = question
    @options = options << abort_prompt
    @answer = ""
    @password = password
    prompt until (processed? || aborted? || raw_input?)
    processed? || raw_input?
  end

  def prompt
    STDOUT.puts dialog
    if @password
      @answer = STDIN.noecho(&:gets).strip.downcase
    else
      @answer = STDIN.gets.strip.downcase
    end
  end

  def dialog
    opts = []
    @options.each_with_index{|opt, i|  opts << "#{i + 1}. #{opt}"}
    opts_str = opts.join("\n")
    "\n#{question}\n#{opts_str}\n"
  end

  def processed?
    (1..@options.size-1).include?(@answer.to_i)
  end

  def aborted?
    @answer.to_i == @options.size
  end

  def raw_input?
    !@answer.strip.empty? && @options.size == 1
  end

  def abort_prompt
    "Cancel"
  end

  def selected
    @options[@answer.to_i - 1]
  end

  def selected_index
    @answer.to_i - 1
  end

  def raw_answer
    @answer
  end
end
