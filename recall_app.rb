require 'sinatra/base'
require 'active_record'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'

class RecallApp < Sinatra::Base

  ActiveRecord::Base.establish_connection(YAML.load(File.open('config/database.yml')))

  class Post < ActiveRecord::Base
    validates :content,
      presence: true
  end

  register Sinatra::Flash
  helpers Sinatra::RedirectWithFlash

  enable :method_override
  enable :sessions
  enable :static

  set :app_file, __FILE__
  set :root, File.dirname(__FILE__)

  SITE_TITLE = "Recall App"

  helpers do
    include Rack::Utils
    alias_method :h, :escape_html
  end

  get '/' do
    @title = 'All notes'
    @posts = Post.all.order('created_at DESC')

    if @posts.empty?
      flash[:error] = 'No notes found, Add your first below.'
    end

    erb :index
  end

  get '/rss.xml' do
    @posts = Post.all.order('created_at DESC')

    builder :rss
  end

  post '/' do
    post = Post.new
    post.content = params[:content]

    if post.save
      redirect '/', :notice => 'Note created successfully'
    else
      redirect '/', :error => 'Failed to save note.'
    end
  end

  get '/:id/complete' do
    post = Post.find_by_id(params[:id])
    post.complete = post.complete ? false : true

    if post.save
      redirect '/', :notice => 'Note updated successfully.'
    else
      redirect '/', :error => 'Failed updating note.'
    end
  end

  get '/:id' do
    @title = "Edit note #{params[:id]}"
    @post = Post.find_by_id(params[:id])

    if @post
      erb :edit
    else
      redirect '/', :error => "Can't find that note."
    end
  end

  put '/:id' do
    post = Post.find(params[:id])
    post.content = params[:content]

    if post.save
      redirect '/', :notice => 'Note updated successfully.'
    else
      redirect '/', :error => 'Failed updating note.'
    end
  end

  get '/:id/delete' do
    @title = "Confirm deletion of note #{params[:id]}"
    @post = Post.find_by_id(params[:id])

    if @post
      erb :delete
    else
      redirect '/', :error => "Can't find that note."
    end
  end

  delete '/:id' do
    post = Post.find_by_id(params[:id])

    begin
      post.destroy
    rescue
      redirect '/', 'Error deleting note.'
    end

    redirect '/', :notice => 'Note deleted successfully'
  end

end
