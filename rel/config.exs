# Import all plugins from `rel/plugins`
# They can then be used by adding `plugin MyPlugin` to
# either an environment, or release definition, where
# `MyPlugin` is the name of the plugin module.
~w(rel plugins *.exs)
|> Path.join()
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Distillery.Releases.Config,
    # This sets the default release built by `mix distillery.release`
    default_release: :default,
    # This sets the default environment used by `mix distillery.release`
    default_environment: Mix.env()

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/config/distillery.html


# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :prod do
  set include_erts: false
  set include_src: false
  set cookie: :"s6%RrhH_&njlgY_{Ou:>pWX$O]^nIwAPDZ/:>jU:zIT}3{4YlULn&SNZr54Wa$VK"
  set pre_configure_hooks: "rel/hooks/pre.configure.d"
  set vm_args: "rel/vm.args"
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix distillery.release`, the first release in the file
# will be used by default

release :is_it_up do
  set version: current_version(:is_it_up)
  set applications: [
    :confex,
    :cowboy,
    :is_it_up,
    :libcluster,
    :timex,
    :logger,
    :plug_cowboy,
    :prometheus_ex,
    :prometheus_process_collector,
    :ex_bench,
    :runtime_tools,
  ]
end

