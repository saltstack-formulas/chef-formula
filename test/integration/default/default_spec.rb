describe file('/etc/chef/client.rb') do
  its('type') { should eq :file }
  its('sha256sum') { should eq '04321b70b47a980944cef2d82dc047face7f0bf91b0f73d6bce8fa527404c3fd' }
end

describe file('/etc/chef/validation.pem') do
  its('type') { should eq :file }
  its('sha256sum') { should eq '167cde4eb6488bfe5c1954484911ce0bf6412a7178d2af5f8ddc4cff3676cac8' }
end
