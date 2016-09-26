# Capistrano 3.x Vagrant stage
# config/deploy/vagrant.rb
require 'pry'
set :stage, :vagrant
set :rails_env, "production"

vagrant_ssh_config = `vagrant ssh-config`.split("\n")[1..-1].map(&:strip).inject({}) do |m, s|
  k, v = s.split(/\s/, 2).map(&:strip); m[k] = v; m
end


server vagrant_ssh_config['HostName'],
  roles: %w{web app db},
  primary: true,
  user: vagrant_ssh_config['User'],
  port: vagrant_ssh_config['Port'],
  ssh_options: {
    keys: [vagrant_ssh_config['IdentityFile']],
    forward_agent: vagrant_ssh_config['ForwardAgent'] == 'yes'
  }
