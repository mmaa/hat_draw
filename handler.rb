require 'sinatra'
require 'slim'

get '/' do
  slim :index
end

post '/' do
  @names = params[:names].split.uniq.shuffle

  if params[:size].strip =~ /^\d+$/
    @size = params[:size].strip.to_i
  else
    @size = @names.size
  end

  @groups = make_groups(@names, @size)

  slim :index
end

def make_groups(names, size)
  remainder = names.size % size
  if remainder.zero? || size - remainder == 1
    names.each_slice(size)
  else
    make_groups(names, size - 1)
  end
end
