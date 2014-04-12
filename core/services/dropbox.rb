require 'core/libs/dropbox_sdk'
require 'yaml'

module Services
  class Dropbox

    DEFAULT_PATH = "/core/services/dropbox"

    def initialize
      #TODO
      #the user auth and test if already have a open session
      #return nil
    end

    def session
      nil
    end

    def authenticate_url
      flow = DropboxOAuth2FlowNoRedirect.new(load_keys['dropbox']['key'], load_keys['dropbox']['secret'])
      flow.start()
    end

    private
    def load_keys
      @access ||= YAML.load(File.open("core/services/dropbox/keys.yml"))
    end

  end
end
