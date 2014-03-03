class downloadParcels {
    exec { "Download CDH 4.5.0 for precise":
        command => "/usr/bin/wget --background -P /opt/cloudera/parcel-repo/ http://archive.cloudera.com/cdh4/parcels/4.6.0/CDH-4.6.0-1.cdh4.6.0.p0.26-precise.parcel",
    }
    exec { "Create SHA file for CDH": 
        command => "/bin/echo \"5f2fe8c2aabfbec6b4892efe200267e30384a923\" > /opt/cloudera/parcel-repo/CDH-4.6.0-1.cdh4.6.0.p0.26-precise.parcel.sha",
    }

    exec { "Download Impala 1.2.3 for precise":
        command => "/usr/bin/wget --background -P /opt/cloudera/parcel-repo/ http://archive.cloudera.com/impala/parcels/1.2.3/IMPALA-1.2.3-1.p0.97-precise.parcel",
    }
    exec { "Create SHA file for Impala": 
        command => "/bin/echo \"859f3ecec037ae08401a960c79c2db52b859e616\" > /opt/cloudera/parcel-repo/IMPALA-1.2.3-1.p0.97-precise.parcel.sha",
    }

    exec { "Download Search 1.1.0 for precise":
        command => "/usr/bin/wget --background -P /opt/cloudera/parcel-repo/ http://archive.cloudera.com/search/parcels/1.2.0/SOLR-1.2.0-1.cdh4.5.0.p0.4-precise.parcel",
    }
    exec { "Create SHA file for Search": 
        command => "/bin/echo \"96db54afef66083f555aa0fa0615d7b91e47fd31\" > /opt/cloudera/parcel-repo/SOLR-1.2.0-1.cdh4.5.0.p0.4-precise.parcel.sha",
    }
}

class { 'cloudera':
  cm_server_host => 'hadoop-master',
  cm_version => '4.8.1',
}
class { 'cloudera::cm::server': }
# class { 'downloadParcels': 
#     require => Class['cloudera::cm::server']
# }
