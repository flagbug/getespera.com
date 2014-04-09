require 'httpclient'
require 'sinatra'
require 'redcarpet'

get '/' do
  erb :index
end

get '/EsperaSetup.exe' do
  redirect 'http://espera.s3.amazonaws.com/EsperaSetup.exe'
end

get '/EsperaPortable.zip' do
  redirect 'http://espera.s3.amazonaws.com/EsperaPortable.zip'
end

get '/EsperaBetaSetup.exe' do
  redirect 'http://espera.s3.amazonaws.com/EsperaBetaSetup.exe'
end

get '/Changelog.md' do
  redirect 'http://espera.s3.amazonaws.com/Changelog.md'
end

get '/Releases/Stable/RELEASES' do
  redirect 'http://espera.s3.amazonaws.com/Releases/RELEASES'
end

get '/Releases/Stable/:name' do
  raise Sinatra::NotFound unless params[:name].match /Espera-\d+.\d+.\d+-(full|delta).nupkg/
  redirect 'http://espera.s3.amazonaws.com/Releases/' + params[:name]
end

get '/release-notes' do
  client = HTTPClient.new
  content = client.get_content("/Changelog.md")
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  @rendered = markdown.render(content)
  
  erb :releasenotes
end

get '/about' do
  erb :about
end
