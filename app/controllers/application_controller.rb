class ApplicationController < ActionController::API

    def home
        render file: 'public/index.html'
    end

    def ping
        render json: {message:"Server is Up!!!"}
    end
end
