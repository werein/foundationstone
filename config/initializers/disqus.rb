if defined? Disqus
  Disqus::defaults[:account] = Foundationstone::Config.disqus
  # so that the comments will load up in development environment
  Disqus::defaults[:developer] = true
  Disqus::defaults[:container_id] = "disqus_thread"
  Disqus::defaults[:show_powered_by] = false
end