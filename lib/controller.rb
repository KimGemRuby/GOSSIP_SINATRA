require 'gossip'
require 'csv'

class ApplicationController < Sinatra::Base
#get '/' do
#"<html><head><title>The Gossip Project</title></head><body><h1>Mon super site de gossip !</h1></body></html>"
#end

  get '/' do
    erb :index, locals: {gossips: Gossip.all}
    "<html><head><title>The Gossip Project</title></head><body><h1>Mon super site de gossip !</h1></body></html>"
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do # le facteur post les gossip
    Gossip.new(params[:gossip_author],params[:gossip_content]).save
    erb :new_gossip_confirmation
    puts "redirect"
    redirect '/'
    puts "g redirect"
  end

  get '/gossips/confirm/' do # La page de confirmation après avoir posté un gossip
    erb :new_gossip_confirmation
  end

  get '/gossip/:num_gossip/' do # Quand on clique sur 'voir le gossip'
    erb :show_one, locals:{ragots: Gossip.read_all, gossip_numb:params[:num_gossip]}
  end

  get '/gossip/:num_edit/edit/' do 
    erb :edit, locals:{ragots: Gossip.read_all, gossip_numb:params[:num_edit]}
  end

  post '/gossip/:num/edit/' do
    Gossip.edit(params[:gossip_author_updated],params[:gossip_content_updated],params[:num])
    redirect '/gossip/edit/confirm/'
  end

  get '/gossip/edit/confirm/' do
    erb :edit_confirm
  end



  
end