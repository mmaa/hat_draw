require 'sinatra'
require 'slim'

get '/' do
  slim :index
end

post '/' do
  @names = params[:names].split(/[\n\r]/).uniq.reject(&:empty?).each(&:strip!)

  if params[:size].strip =~ /^\d+$/
    @size = params[:size].strip.to_i
  else
    @size = @names.size
  end

  @groups = make_groups(@names.shuffle, @size)

  slim :index
end

def make_groups(names, size)
  groups = names.each_slice(size).to_a

  while groups.first.size - groups.last.size > 1
    groups[0..-2].each do |g|
      if g.size - groups.last.size > 1
        groups.last << g.pop
      end
    end
  end

  groups
end
