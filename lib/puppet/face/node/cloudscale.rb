require 'puppet/cloudpack'
require 'puppet/cloudscale'

Puppet::Face.define :node, '0.0.1' do
  action :images do
    summary 'List available images'
    description <<-EOT
      Lists all available images owned by the account configured by fog
    EOT

    when_invoked do |options|
      Puppet::CloudPack.images(options)
    end
  end

  action :bootstrap_cloudscale do
    summary 'Bootstrap an instance with an auto generated cert'
    description <<-EOT
      Does the same thing as the Cloud Provisioner boostrap action, but
      generates the cert based on the DNS name provided at time of the 
      instance creation
    EOT

    Puppet::CloudPack.add_bootstrap_options(self)
    when_invoked do |options|
      Puppet::CloudPack.bootstrap_cloudscale(options)
    end
  end

  action :new_ami do
    summary 'Update an EBS backed AMI from an instance'
    description <<-EOT
      Generates a new AMI from an running instance.  The instance will be
      rebooted in order to snapshot it.
    EOT
    Puppet::CloudPack.add_new_ami_options(self)
    when_invoked do |server, options|
      Puppet::CloudPack.new_ami(server,options)
    end
  end
end
