require 'homestead/nneren'
require 'yaml'

describe Homestead::Nneren::RetsImporter do
  subject { Homestead::Nneren::RetsImporter.new login_config}
  let(:login_config) do
    config = YAML.load_file 'spec/conf/login_config.yml'
    config.keys.inject({}) { |a, k| a.merge({k.to_sym => config[k]}) }
  end
  it 'should update' do
    count = 0
    subject.update_properties(1, ['(StateOrProvince=VT)']) do |resource|
      p resource['ListDate']
      count += 1
    end
    puts count
  end
end
