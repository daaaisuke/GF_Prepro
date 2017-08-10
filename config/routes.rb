Rails.application.routes.draw do
  root 'image/register#index'

  namespace :image do
    post 'register' => 'register#register'
    post 'next'     => 'register#next'
    get  'reset'    => 'register#reset'
    get  'download' => 'register#download'
    delete 'delete' => 'register#delete'
  end
end
