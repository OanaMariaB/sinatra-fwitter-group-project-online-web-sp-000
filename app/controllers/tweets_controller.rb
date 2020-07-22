class TweetsController < ApplicationController

    get '/tweets' do
      if Helpers.logged_in?(session)
       @tweets = Tweet.all 
       erb :'tweets/tweets'
      else
     redirect '/login'
      end 
    end

    get '/tweets/new' do
      if Helpers.logged_in?(session)
        erb :'tweets/new'
      else
        redirect '/login'
      end
    end

    post '/tweets' do
      if Helpers.logged_in?(session)
          if params[:content].empty?
              redirect '/tweets/new'
          else
              tweet = Tweet.new
              tweet.content = params[:content]
              tweet.user = Helpers.current_user(session)
              tweet.save
              
              redirect "/tweets/#{tweet.id}"
          end
      else
          redirect '/login'
    end

  end

  get '/tweets/:id' do
    if Helpers.is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
    redirect '/login' 
    end 
  end 
  
end #class
