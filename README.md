Build the gem:
`gem build vibes_client.gemspec`

Install the gem:
`gem install vibes_client-0.0.0.gem`

== OR ==

`rake build_and_install`

== OR ==

`rake bi`

Configure `irb`'s load path to use a local gem
`irb -Ilib vibes_client`

Run the bin CLI
`ruby -Ilib ./bin/vbc`

Periodically update type checked modules:
`bin/tapioca todo`