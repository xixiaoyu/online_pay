require 'digest/md5'

module OnlinePay
  module WxSign
    def self.generate(params)
      key = params.delete(:key)

      query = params.sort.map do |k, v|
        "#{k}=#{v}" if v.to_s != ''
      end.compact.join('&')

      Digest::MD5.hexdigest("#{query}&key=#{key || OnlinePay.wx_key}").upcase
    end

    def self.verify?(params)
      params = params.dup
      sign = params.delete('sign') || params.delete(:sign)

      generate(params) == sign
    end
  end
end
