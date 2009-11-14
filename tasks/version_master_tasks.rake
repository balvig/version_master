desc "Displays current version"
task :version => :environment do
  puts "Current version is #{VersionMaster::Version.new.to_s}"
end

namespace :version do
  desc "Bump version number"
  task :bump => :environment do
    version = VersionMaster::Version.new
    puts "Bumped version #{version.to_s} --> #{ENV['VER'] ? version.bump(ENV['VER']) : version.bump}"
  end
  
  desc "Set version number"
  task :set => :environment do
    version = VersionMaster::Version.new
    puts "Changed version #{version.to_s} --> #{version.set(ENV['VER'])}"
  end
end

