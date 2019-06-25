ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure("2") do |config|

    config.vm.box = "debian/stretch64"
    config.vm.network "private_network", ip: "192.168.56.2"

    # Use ACT_DEVELOPER_* env vars to set vm hardware resources.
    vbox_custom = %w[cpus memory].map do |hw|
        key = "ACT_DEVELOPER_#{hw.upcase}"
        ENV[key] ? ["--#{hw}", ENV[key]] : []
    end.flatten

    config.vm.post_up_message = $msg

    config.vm.provider :virtualbox do |vb|
        vb.name = "act-stretch"
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        if not vbox_custom.empty?
            vb.customize [ "modifyvm", :id, *vbox_custom ]
        end
    end

    config.vm.synced_folder '.', '/vagrant', disabled: true
    config.vm.synced_folder ".", "/home/vagrant/act"

    config.vm.provision :shell, :path => 'provision/all.sh'
end
