class { 'cloudera':
  cm_server_host => "hadoop-master",
  use_parcels    => true,
}
# install all repos
# class { 'cloudera::cdh::repo' :}
# class { 'cloudera::impala::repo': }
# class { 'cloudera::search::repo': }
# class { 'cloudera::gplextras::repo': }


# exec {'/usr/bin/apt-get update': }

# class { 'cloudera::cdh': }
# class { 'cloudera::impala': }

# class { 'cloudera::cdh::mahout': }
# class { 'cloudera::cdh::sqoop': }

# class { 'cloudera::cdh::hue': }
# class { 'cloudera::cdh::hive': }
# class { 'cloudera::cdh::zookeeper': }
# class { 'cloudera::cdh::oozie': }
# class { 'cloudera::cdh::hadoop': }

# class { 'cloudera::search::mapreduce': }


# Install:
# Hadoop
# Hive
# Hue
# Oozie
# ZooKeeper
# MapReduce



