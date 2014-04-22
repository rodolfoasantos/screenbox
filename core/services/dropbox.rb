require 'core/libs/dropbox_sdk'
require 'yaml'

module Services
  class Dropbox

    DEFAULT_PATH = "/core/services/dropbox/"
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

    def authorizate(code)
      token, use_id = @flow.finish(code)
      @client = DropboxClient.new(token)
    end

    def linked_account
      @client.account_info() unless @client.nil?
    end

    def upload_file(filename, file)
      begin
        response = @client.put_file(DEFAULT_UPLOAD_PATH + filename, file)
      raise DropboxError.new("error when try to upload the screenshot") if response["modified"].nil?
      end
    end

    private
    def load_keys
      @access ||= YAML.load(File.open(DEFAULT_PATH + "keys.yml"))
    end

  end

end
