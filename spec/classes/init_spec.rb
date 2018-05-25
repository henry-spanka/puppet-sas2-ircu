require 'spec_helper'
describe 'sas2_ircu' do
  context 'with default values for all parameters' do
    it { should contain_class('sas2_ircu') }
  end
end
