Rails.application.routes.draw do
  root 'questions#index'
  post '/upload' => "questions#upload"
end
