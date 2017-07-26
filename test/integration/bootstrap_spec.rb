describe file('/etc/chef/client.rb') do
  it { should exist }
  it { should be_file }
end

describe file('/etc/chef/validation.pem') do
  it { should exist }
  it { should be_file }
end
