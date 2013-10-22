require 'homestead/nneren'
require 'yaml'

describe Homestead::Nneren::RetsImporter do
  subject { Homestead::Nneren::RetsImporter.new login_config}
  let(:login_config) do
    config = YAML.load_file 'spec/conf/login_config.yml'
    config.keys.inject({}) { |a, k| a.merge({k.to_sym => config[k]}) }
  end
  it 'should update' do
    p login_config
    subject.update_properties
  end
end
