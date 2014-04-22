require 'core/libs/dropbox_sdk'
require 'yaml'

module Services
  class Dropbox

    DEFAULT_CONF_PATH = "core/services/dropbox/"
    DEFAULT_UPLOAD_PATH = "/public/"

    def initialize
      @flow = DropboxOAuth2FlowNoRedirect.new(load_keys['dropbox']['key'], load_keys['dropbox']['secret'])
      @client = nil
    end

    def session
      nil
    end

    def authenticate_url
      @flow.start()
    end

    def authorize(code)
      token, use_id = @flow.finish(code)
      @client = DropboxClient.new(token)
    end

    def linked_account
      @client.account_info() unless @client.nil?
    end
#Pk08anIKHSoAAAAAAAAAyBd1751VN24_6E2MWsT-AP4
    def upload_file(file)
      begin
        response = @client.put_file(DEFAULT_UPLOAD_PATH + file.get_name, file)
      raise DropboxError.new("error when try to upload the screenshot") if response["modified"].nil?
      end
    end

    private
    def load_keys
      @access ||= YAML.load(File.open(DEFAULT_CONF_PATH + "keys.yml"))
    end

  end

end
