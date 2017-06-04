require 'spec_helper'
require 'yaml'
require 'json'
include Awspec::Helper::Finder

json = JSON.parse(File.read("/tmp/vars.json"))

subnets = json['subnets']

describe "Subnets" do
  unless subnets.nil? || subnets == 0
    subnets.each do |subnet|

      describe subnet(subnet['name']) do
        it { should exist }
      end

    end
  else
    fail "A subnet must be defined in the config"
  end
end

