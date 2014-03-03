Exec {
    path => [
        '/usr/local/sbin'
        , '/usr/local/bin'
        , '/usr/sbin'
        , '/usr/bin'
        , '/sbin'
        , '/bin'
    ]
}

class packages {
    exec { 'Update Repositories':
        command => 'apt-get update'
    }

    package { 'Install expect':
        name => "expect",
        ensure => "present",
        require => Exec['Update Repositories']
    }

    exec { 'Download latest version of Cloudera Manager Installer':
        cwd => "/tmp",
        command => 'wget http://archive.cloudera.com/cm4/installer/latest/cloudera-manager-installer.bin',
        require => Package['Install expect'],
        creates => "/tmp/cloudera-manager-installer.bin"
    }

    exec { 'Make sure cloudera-manager-installer is executable':
        cwd => "/tmp",
        command => "chmod +x cloudera-manager-installer.bin",
        require => Exec['Download latest version of Cloudera Manager Installer']
    }

    exec { 'Install Cloudera Manager':
        cwd => "/tmp",
        command => 'expect -c "spawn /tmp/cloudera-manager-installer.bin -i-agree-to-all-licenses -noreadme -noprompt -nooption; wait $spawn_id"',
        require => Exec['Make sure cloudera-manager-installer is executable'],
        timeout => 900,
        creates => "/usr/share/cmf/.mojosetup/manifest/cloudera-manager.txt"
    }
}



class {'packages':}
