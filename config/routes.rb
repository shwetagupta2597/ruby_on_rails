Rails.application.routes.draw do


 # get 'welcome/home', to: 'welcome#home'

  get 'welcome/login' #, to: 'welcome#login'

  post 'welcome/login' #, to: 'welcome#login'

  post 'welcome/logout', to: 'welcome#logout'

  get 'welcome/uploadFile', to: 'welcome#uploadFile'

  post 'welcome/uploadFile', to: 'welcome#uploadFile'

  get 'welcome/resumedownload', to: 'welcome#resumedownload'
  get 'welcome/tl_content', to: 'welcome#tl_content'

  #get 'welcome/upload' #, to: 'welcome#upload'


  get 'welcome/dash_upload.html', to: 'welcome#dash_upload'

  post 'welcome/dash_upload.html', to: 'welcome#dash_upload'

  post 'pages/uploadFile' => 'pages#uploadFile'

#root 'welcome#login'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
