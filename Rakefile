require 'rake'

backend_dir = 'rails'
frontend_dir = 'ember'
deployment_branch = 'production-build'
heroku_app = 'ilg-rails'

task :run do
  pids = [
    spawn("cd #{backend_dir} && rails s -p 3900"),
    spawn("cd #{frontend_dir} && ./node_modules/.bin/#{frontend_dir} server --port=4900 --proxy=http://localhost:3900"),
  ]

  trap 'INT' do
    Process.kill 'INT', *pids
    exit 1
  end

  loop do
    sleep 1
  end
end
