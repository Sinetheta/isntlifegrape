require 'rake'

backend_dir = 'rails'
frontend_dir = 'ember'
deployment_branch = 'production-build'
heroku_app = 'ilg-rails'

task :run do
  pids = [
    spawn("cd #{backend_dir} && rails s -p 3900"),
    spawn("cd #{frontend_dir} && ./node_modules/.bin/ember server --port=4900 --proxy=http://localhost:3900"),
  ]

  trap 'INT' do
    Process.kill 'INT', *pids
    exit 1
  end

  loop do
    sleep 1
  end
end

task :deploy do
  # we use a deployment branch which includes a compiled frontend
  sh "git checkout #{deployment_branch}"
  sh 'git merge master --strategy-option theirs --squash -m "Merging master for deployment"'
  # replace the rails public assets with the pre-compiled ember app
  sh "rm -rf #{backend_dir}/public/*"
  sh "cd #{frontend_dir} && ember build production && cd .."
  sh "mv #{frontend_dir}/dist/* #{backend_dir}/public/"

  # in case there have been no changes to the frontend since last deploy
  unless `git status` =~ /nothing to commit, working directory clean/
    sh 'git add -A'
    sh 'git commit -am "Add assets" || true'
  end

  # push only the backend (and frontend assets)
  sh "git push heroku `git subtree split --prefix #{backend_dir} #{deployment_branch}`:master --force"

  # create a tag to match the heroku releases
  release_output = `heroku releases -a #{heroku_app}`.split "\n"
  latest_release = "heroku-#{release_output[1].match(/v\d+/).to_s}"

  tags = `git tag`

  # in case there have been no changes since last deploy
  unless tags.include? latest_release
    sh "git tag #{latest_release}"
  end

  sh 'git checkout -'
end
