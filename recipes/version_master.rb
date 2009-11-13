namespace :deploy do
  
  desc "Bump version number and deploy"
  task :bump do
    version.bump
    update_code
    symlink
    restart
  end
  
  namespace :version do
  
    desc "Bump version number"
    task :bump do
      rake_params = ENV['VER'] ? "VER=#{ENV['VER']}" : ''
      system "rake version:bump #{rake_params}"
    end
    
    desc "Upload version config file"
    task :upload_config do
      VERSION_FILE_PATH = 'config/version.yml'
      top.upload VERSION_FILE_PATH, "#{release_path}/#{VERSION_FILE_PATH}"
    end
  end
  
  after 'deploy:update_code', 'deploy:version:upload_config'
  
end