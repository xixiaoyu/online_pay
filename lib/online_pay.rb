require 'online_pay/version'
require 'online_pay/wx_result'
require 'online_pay/wx_service'
require 'online_pay/wx_sign'
require 'online_pay/sheng_pay_result'
require 'online_pay/sheng_pay_service'
require 'online_pay/sheng_pay_sign'
require 'online_pay/alipay_result'
require 'online_pay/alipay_service'
require 'online_pay/alipay_sign'
require 'openssl'

module OnlinePay
  @wx_extra_rest_client_options = {}
  @debug_mode = true

  class << self
    # 公用参数
    attr_accessor :debug_mode

    # 微信支付相关参数
    # wx_key 指的是 paterner_key
    attr_accessor :wx_app_id, :wx_mch_id, :wx_key, :wx_app_secret, :wx_extra_rest_client_options,
    attr_reader :wx_apiclient_cert, :wx_apiclient_key


    # payment_params = {
    #     Name: ShengpayPaymentSetting.name,
    #     Version: ShengpayPaymentSetting.payment_version,
    #     Charset: ShengpayPaymentSetting.charset,
    #     MsgSender: ShengpayPaymentSetting.merchant_id,
    #     OrderNo: order_number,
    #     # TODO: yicong 需要公共模型可以处理
    #     # OrderAmount: format('%.2f', actual_price),
    #     # TODO 测试阶段， 金额全部从零开始缴费
    #     OrderAmount: format('%.2f', 0.1),
    #     OrderTime: order_time.strftime('%Y%m%d%H%M%S'),
    #     Currency: target_currency.code,
    #     PageUrl: page_url,
    #     NotifyUrl: notify_url,
    #     BuyerIp: current_ip,
    #     realName: student.name,
    #     idNo: student.id_number,
    #     mobile: student.phone,
    #     Ext1: ext1,
    #     SignType: ShengpayPaymentSetting.sign_type
    # }

    # 盛付通支付相关参数
    attr_accessor :shengpay_name, :shengpay_payment_version, :shengpay_exchange_rate_version, :shengpay_merchant_id,
                  :shengpay_merchant_key, :shengpay_charset, :shengpay_sign_type

    def set_apiclient_by_pkcs12(str, pass)
      pkc12 = OpenSSL::PKCS12.new(str, pass)

      @wx_apiclient_cert = pkc12.certificate
      @wx_apiclient_key = pkc12.key
    end

    def wx_apiclient_cert=(cert)
      @wx_apiclient_cert = OpenSSL::X509::Certificate.new(cert)
    end

    def wx_apiclient_key=(key)
      @wx_apiclient_key = OpenSSL::PKey::RSA.new(key)
    end

    def debug_mode?
      @debug_mode || false
    end
  end

end
