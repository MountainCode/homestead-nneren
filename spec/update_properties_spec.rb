require 'spec_helper'
require "active_record"
require "rails"
require 'homestead/nneren'
require 'yaml'

describe Homestead::Nneren::RetsImporter do

  subject { Homestead::Nneren::RetsImporter.new login_config}
  let(:login_config) do
    config = YAML.load_file 'spec/conf/login_config.yml'
    config.keys.inject({}) { |a, k| a.merge({k.to_sym => config[k]}) }
  end

  it 'should fetch properties' do
    count = 0
    subject.fetch_properties(1, ['(StateOrProvince=VT)']) do |resource, type|
      id = resource['ListingID']
      File.open("fixtures/#{id}.yml", 'w') {|f| YAML.dump resource, f} if count < 50
      count += 1
    end
    puts count
  end

  it 'should update properties' do
    subject.update_properties(1, ['(StateOrProvince=VT)']) do |listing|
      p listing
    end
  end
end
