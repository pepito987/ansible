require 'spec_helper'
require 'yaml'
require 'json'
include Awspec::Helper::Finder

describe internet_gateway("public-vpc") do
  it { should exist }
end