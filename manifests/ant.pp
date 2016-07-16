define sdkman::ant(
  $version = $name,
  $default = false
) {
  require sdkman::install

  exec { "install-ant-$name":
    command => "bash --login -c 'sdk install ant ${version}'",
    creates => "/Users/${::boxen_user}/.sdkman/candidates/ant/${version}"
  }

  if($default) {
    exec { "set-ant-default":
      command => "bash --login -c 'sdk default ant ${version}'",
      require => Exec["install-ant-$name"],
    }
  }
}
