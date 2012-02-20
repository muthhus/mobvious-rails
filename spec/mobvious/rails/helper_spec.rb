require 'spec_helper'
require 'mobvious/rails/helper'

module Mobvious
module Rails
class HelperSpec < MiniTest::Spec
  describe Helper do
    before do
      @env = mock 'env'
      @env.stubs('[]').with('mobvious.device_type').returns(:mobile)

      @request = mock 'request'
      @request.stubs(:env).returns(@env)
      mock_request = @request

      @helper = Object.new
      @helper.extend Helper
      @helper.define_singleton_method(:request) do
        mock_request
      end
    end

    it "runs the provided block only for corresponding device type" do
      mobile_block_executed = false
      desktop_block_executed = false

      @helper.device :mobile do
        mobile_block_executed = true
      end
      @helper.device :desktop do
        desktop_block_executed = true
      end

      mobile_block_executed.must_equal true
      desktop_block_executed.must_equal false
    end

    it "returns current device type" do
      @helper.device_type.must_equal :mobile
    end
  end
end
end
end
