namespace :deploy do
  
  desc "Bump version number and deploy"
  task :bump do
    update_code
    bump_version
    symlink
    restart
  end
  
  desc "Bump version number"
  task :bump_version do
    version_file_path = 'config/version.yml'
    rake_params = ENV['VERSION'] ? "VER=#{ENV['VER']}" : ''
    system "rake version:bump #{rake_params}"
    top.upload version_file_path, "#{release_path}/#{version_file_path}"
  end
  
end