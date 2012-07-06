server "69.55.54.175", :web, :app, :db, primary: true
set :rails_env, "staging"
set :branch, "staging"

namespace :service do
  namespace :unicorn do
    %w[start stop restart].each do |cmd|
      desc "#{cmd} unicorn"
      task cmd, roles: :app, except: {no_release: true} do
        run "/etc/init.d/unicorn_closetgroupie #{cmd}"
      end
    end

    desc "Stop/Start unicorn"
    task :stopstart, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_closetgroupie stop"
      run "/etc/init.d/unicorn_closetgroupie start"
    end
  end
end
