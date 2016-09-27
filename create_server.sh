
# echo "Installing  curl vim git nginx"

# apt-get install curl vim git-core nginx -y libpq-dev

# echo "Create deploy user"
# useradd -m deploy -s /bin/bash
# echo "deploy:deploy_password" | chpasswd
 

# echo "Configuring Nginx"
# echo "Create a backup of the nginx configuration file."
# cp -Rfa /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bkp


# cat <<EOF > /etc/nginx/nginx.conf
# #/etc/nginx/nginx.conf
# ## User that the server runs as
# user www-data;
# ## how many nginx instances actually run
# worker_processes 4;
# ## Where it stores the process ID of the master process.
# pid /run/nginx.pid;

# ## defines how the daemon incoming requests at the system level
# events {
#         ## how many connections a sinble worker thread is allowed to process
#         worker_connections 768;
#         ## keep accepting connections even though the server hasn't finished handeling incoming connections.
#         # multi_accept on;
# }

# ## This is where most of your tuning will take place
# http {
#         ## GLOBAL
#         ## Enabling this will increase the speed that nginx can cache, and retreive from cache
#         sendfile on;
#         ## This option causes nginx to attempt to send it's HTTP response headers in one packet.
#         tcp_nopush on;
#         ## This disables a buffer that when used with keep-alive connections, can slow things down
#         tcp_nodelay on;
#         ## Defines the maximum time between keepalive requests from client browsers.
#         keepalive_timeout 65;
#         ## Defines the maximum size of hash tables. This directly influences cache performance. Higher numbers use more memory, and offer potentially higher performance.
#         types_hash_max_size 2048;
#         ## Sets the maximum allowed size of the client request body, specified in the “Content-Length” request header field.
#         client_max_body_size 20M;
#         ## Sets buffer size for reading client request body.
#         client_body_buffer_size 128k;
#         ## Enables or disables emitting nginx version in error messages and in the “Server” response header field.
#         server_tokens off;
#         ## Sets the bucket size for the server names hash tables.
#         # server_names_hash_bucket_size 64;
#         ## Enables or disables the use of the primary server name, specified by the server_name directive, in redirects issued by nginx.
#         # server_name_in_redirect off;
#         ## Includes mime.types configuration file
#         include /etc/nginx/mime.types;
#         ## Defines the default MIME type of a response. Mapping of file name extensions to MIME types can be set with the types directive.
#         default_type application/octet-stream;

#         ## Logging Settings
#         access_log /var/log/nginx/access.log combined;
#         error_log /var/log/nginx/error.log;

#         ## Gzip Settings
#         ## Enables or disables gzipping of responses.
#         gzip on;
#         ## Disables gzipping of responses for requests with “User-Agent” header fields matching any of the specified regular expressions.
#         gzip_disable "msie6";
#         ## Enables or disables inserting the “Vary: Accept-Encoding” response header field if the directives gzip, gzip_static, or gunzip are active
#         gzip_vary on;
#         ## Enables or disables gzipping of responses for proxied requests depending on the request and response.
#         gzip_proxied any;
#         ## Sets a gzip compression level of a response. Acceptable values are in the range from 1 to 9.
#         gzip_comp_level 6;
#         ## Sets the number and size of buffers used to compress a response. By default, the buffer size is equal to one memory page.
#         gzip_buffers 16 8k;
#         ## Sets the minimum HTTP version of a request required to compress a response.
#         gzip_http_version 1.1;
#         ##  Enables gzipping of responses for the specified MIME types in addition to “text/html”.
#         gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript;


#         ## Virtual Host Configs
#         include /etc/nginx/conf.d/*.conf;
#         include /etc/nginx/sites-enabled/*;
# }

# EOF

# echo "Disable the default virtual Host"

# unlink /etc/nginx/sites-enabled/default

# echo "Installing the postgresql Server"

# apt-get install -y  --install-suggests postgresql-9.4  

# service postgresql start

# su - postgres <<-'EOF'
#         psql -c "CREATE USER deploy PASSWORD 'deploy_password';"
#         psql -c "CREATE DATABASE deploy_production with OWNER deploy;"
#         psql -c "ALTER ROLE deploy WITH createdb;"
#         psql -c "ALTER ROLE deploy WITH superuser;"
# EOF

# gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

# curl -sSL https://get.rvm.io | bash -s stable
# gpasswd -a deploy rvm

# source /etc/profile.d/rvm.sh

# rvm install 2.3.0
# rvm use 2.3.0 --default
# touch ~/.gemrc
# echo "
# gem: --no-ri --no-rdoc
# benchmark: false
# verbose: true
# update_sources: true
# sources: 
# - http://gems.rubyforge.org/
# - http://rubygems.org/
# backtrace: true
# bulk_threshold: 1000
# ">> ~/.gemrc
# gem install bundler -V --no-ri --no-rdoc
# gem install rails -V --no-ri --no-rdoc

# ssh -T git@github.com

su deploy << 'EOF'

if [ -d "/home/deploy/.ssh/id_rsa.pub" ];then
  echo "ssh keys already generated"
else 
  echo -e "\n\n\n\n" |ssh-keygen -t rsa
   echo -e "\n\n\n\n" |ssh-keygen -t dsa
fi
echo "add to github the content of `cat ~/.ssh/id_rsa.pub`"
echo "run localy : cat ~/.ssh/id_rsa.pub | ssh -p your_port_num deploy@your_server_ip 'cat >> ~/.ssh/authorized_keys'"

if [ -d "/home/deploy/apps" ] ; then 
  echo "apps directory already exist!"

else
  echo "Create apps directory"
    mkdir /home/deploy/apps
    git clone https://github.com/plombix/Group_app.git /home/deploy/apps/Group_app
fi
EOF
# curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
# apt-get install -y nodejs

cd ~/apps/Group_app
echo `whoami`

 echo `whoami`
 echo `pwd`
 echo ${PATH}
  `which bundler`

  KEY="$(rake secret)"
  echo "production:">>config/secrets.yml
  echo "  secret_key_base: ${KEY}">>config/secrets.yml
  echo "">>config/secrets.yml


# cap install
# echo "
# # Load DSL and Setup Up Stages
# require 'capistrano/setup'
# require 'capistrano/deploy'
# require 'capistrano/rails'
# require 'capistrano/bundler'
# require 'capistrano/rvm'
# require 'capistrano/puma'

# # Loads custom tasks from 'lib/capistrano/tasks' if you have any defined.
# Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
# " > Capfile
# sudo -u deploy  bundle install
# curl -s https://gist.githubusercontent.com/plombix/9c796f20163aba499547e87259e12034/raw/267da9a5720b84efb6147a3942183405e6e9b0f3/deploy.rb > config/deploy.rb

touch config/nginx.conf

echo "upstream puma {
  server unix:/home/deploy/apps/Group_app/shared/tmp/sockets/puma.sock;
}
# Default server configuration
server {
  ## Sets the address and port for IP, or the path for a UNIX-domain socket on which the server will accept requests.
  listen 80;
  
  ## Sets names of a virtual server
  server_name monsite.com;

  ## Enables or disables emitting nginx version in error messages and in the 'Server' response header field.
  server_tokens off;
  
  ## Sets the root directory for requests
  root /home/deploy/apps/chat/current/public;
  
  ## Logging
  access_log /home/deploy/apps/Group_app/current/log/nginx.access.log;
  error_log /home/deploy/apps/Group_app/current/log/nginx.error.log info;

  ## Sets configuration for assets
  location ^~ /assets/ {
    gzip_static on;
    expires max;
    add_header Cache-Control public;
  }

  ## Sets the configuration for all files and the puma web server
  try_files $uri/index.html $uri @puma;
  location @puma {
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_redirect off;

    proxy_pass http://puma;
  }

  ## Default error pages
  error_page 500 502 503 504 /500.html;
  
  ## Sets configuration for max body size as 10MB
  client_max_body_size 10M;
  
  ## Sets How long an idle keepalive connection remains open.
  keepalive_timeout 10;
}

">config/nginx.conf
# git config --global user.name 'plombix_deploy'
# git config --global user.email plombix@gmail.com

# git add -A
# git commit -m "Set up Puma, Nginx & Capistrano"
# git push origin master

# cap production deploy:initial

# cap production deploy:seed

# cap production deploy:restart

# ln -nfs "/home/deploy/apps/Group_app/current/config/nginx.conf" "/etc/nginx/sites-enabled/dqs-rails-base"
# systemctl restart nginx
