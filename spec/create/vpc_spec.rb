require 'spec_helper'
require 'yaml'
require 'json'
include Awspec::Helper::Finder

describe vpc("public-vpc") do
  it { should exist }
end