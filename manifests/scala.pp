define sdkman::scala(
  $version = $name,
  $default = false
) {
  require sdkman::install

  exec { "install-scala-$name":
    command => "bash --login -c 'sdk install scala ${version}'",
    creates => "/Users/${::boxen_user}/.sdkman/candidates/scala/${version}"
  }

  if($default) {
    exec { "set-scala-default":
      command => "bash --login -c 'sdk default scala ${version}'",
      require => Exec["install-scala-$name"],
    }
  }
}
