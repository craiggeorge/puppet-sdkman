define sdkman::ant(
  $version = $name,
  $default = false,
  $dependencies,
) {

  require stdlib
  require sdkman::install

  exec { "install-ant-$name":
    command => "bash --login -c 'sdk install ant ${version}'",
    creates => "/Users/${::boxen_user}/.sdkman/candidates/ant/${version}",
  }

  if ($default) {
    exec { "set-ant-default":
      command => "bash --login -c 'sdk default ant ${version}'",
      require => Exec["install-ant-$name"],
    }
  }

  if ($dependencies) {
    $dep_targets = join($dependencies, " ")
    exec { "fetch ant dependencies":
      cwd     => "/Users/${boxen_user}/.sdkman/candidates/ant/${version}",
      path    => ["/Users/${boxen_user}/.sdkman/candidates/ant/${version}/bin", "/usr/local/bin", "/usr/bin", "/bin", "/usr/sbin"],
      command => "ant -f fetch.xml ${dep_targets} -Ddest=system",
      require => Exec["install-ant-$name"],
    }
  }

}
