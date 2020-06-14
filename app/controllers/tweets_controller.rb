class TweetsController < ApplicationController

     get '/tweets' do
        if Helpers.logged_in?(session)
          @user = Helpers.current_user(session)
          erb :'/tweets/tweets'
        else
          redirect to '/login'
        end
      end
end
