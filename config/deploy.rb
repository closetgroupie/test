require 'bundler/capistrano'
require "rvm/capistrano"

server "69.55.55.82", :web, :app, :db, primary: true

set :rvm_type, :system
set :application, "closetgroupie"

set :scm, :git
# set :repository,  "git@bitbucket.org:joonas/cgx.git"
set :repository,  "git@github.com:closetgroupie/ClosetGroupie.git"
set :branch, "master"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/srv/www/#{application}"

set :user, "deploy"
# set :scm_username, "deploy"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :service do
  namespace :unicorn do
    %w[start stop restart].each do |cmd|
      desc "#{cmd} unicorn"
      task cmd, roles: :app, except: {no_release: true} do
        run "/usr/local/rvm/wrappers/ruby-1.9.3-p194/unicorn_closetgroupie #{cmd}"
      end
    end

    desc "Stop/Start unicorn"
    task :stopstart, roles: :app, except: {no_release: true} do
      run "/usr/local/rvm/wrappers/ruby-1.9.3-p194/unicorn_closetgroupie stop"
      run "/usr/local/rvm/wrappers/ruby-1.9.3-p194/unicorn_closetgroupie start"
    end
  end

  namespace :nginx do
    %w[start stop restart configtest].each do |cmd|
      desc "#{cmd} nginx"
      task cmd, roles: :web, except: {no_release: true} do
        sudo "service nginx #{cmd}"
      end
    end
  end
end

namespace :uploads do
  desc "Sets up the public uploads symlink"
  task :symlink, roles: :app do
    run "ln -nfs #{shared_path}/public/uploads #{current_path}/public/uploads"
  end
  after "deploy:create_symlink", "uploads:symlink"
end

namespace :deploy do
  task :restart do
    service.unicorn.restart
  end

  task :symlink_nginx, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx_80.conf /etc/nginx/sites-enabled/#{application}_80"
    sudo "ln -nfs #{current_path}/config/nginx_443.conf /etc/nginx/sites-enabled/#{application}_443"
    sudo "rm /etc/nginx/sites-enabled/#{application}"
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end
