desc "Displays current version"
task :version => :environment do
  puts "Current version is #{VersionMaster::Version.new.to_s}"
end

namespace :version do
  desc "Bump version number"
  task :bump => :environment do
    version = VersionMaster::Version.new
    old_version = version.to_s
    ENV['VER'] ? version.bump(ENV['VER']) : version.bump
    new_version = version.to_s
    puts "Bumped version #{old_version} --> #{new_version}"
  end
  
  desc "Set version number"
  task :set => :environment do
    version = VersionMaster::Version.new
    old_version = version.to_s
    version.set(ENV['VER'])
    new_version = version.to_s
    puts "Changed version #{old_version} --> #{new_version}"
  end
end
