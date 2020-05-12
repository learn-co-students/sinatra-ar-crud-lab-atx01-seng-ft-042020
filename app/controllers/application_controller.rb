
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  get '/articles/:id' do
    @article = Article.find_by(id: params["id"].to_i)
    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find_by(id: params["id"].to_i)
    erb :edit
  end

  post '/articles' do
    article = Article.create(params)
    redirect "articles/#{article.id}"
  end

  patch '/articles/:id' do
    article = Article.find_by(id: params["id"])
    article.title = params["title"]
    article.content = params["content"]
    article.save
    redirect "articles/#{article.id}"
  end

  delete '/articles/:id' do 
    puts params
    Article.find_by(id: params["id"]).destroy
    redirect '/articles'
  end
end
