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

  @groups = @names.each_slice(@size)

  slim :index
end
