module VersionMaster
  class Version
    
    DEFAULT_YAML_FILE_PATH = "#{RAILS_ROOT}/config/version.yml"
    
    def initialize(yaml_file_path=DEFAULT_YAML_FILE_PATH)
      @yaml_file_path = yaml_file_path
      @parts ||= YAML.load(File.read(@yaml_file_path)).symbolize_keys
    end
    
    def bump(ver= :patch)
      ver = ver.to_sym
      @parts[ver] += 1
      if ver == :minor
        @parts[:patch] = 0
        if @parts[:minor] >= 10
          @parts[:major] += 1
          @parts[:minor] = 0
        end
      elsif ver == :major
        @parts[:minor] = @parts[:patch] = 0
      end
      save
    end
    
    def set(new_version)
      @parts[:major], @parts[:minor], @parts[:patch] = new_version.split('.').collect(&:to_i)
      save
    end
      
    def to_s
      "#{major}.#{minor}.#{patch}"
    end
    
    def method_missing(method, *args)
      if [:major,:minor,:patch].include?(method)
        @parts[method]
      else
        super
      end
    end
    
    private
    
    def save
      File.open(@yaml_file_path, 'w') {|f| f.write(@parts.to_yaml) }
      to_s
    end
  end
end

APP_VERSION = VersionMaster::Version.new.to_s