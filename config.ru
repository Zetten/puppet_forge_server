require 'rubygems'
require 'puppet_forge_server'

# Set base cache directory for proxy backends 
cache_dir = '/forge/cache' # default: File.join(Dir.tmpdir.to_s, 'puppet-forge-server', 'cache')

# Create backends
backends = [
  PuppetForgeServer::Backends::Directory.new('/forge/modules'),
  # Add directory backend for serving cached modules in case proxy flips over
  PuppetForgeServer::Backends::Directory.new(cache_dir),
  PuppetForgeServer::Backends::ProxyV3.new('https://forgeapi.puppetlabs.com', cache_dir)
]

# Disable access logging, log errors to STDERR
PuppetForgeServer::Logger.set({:server => STDERR, :access => File.open(File::NULL, "w")})

# Run
run PuppetForgeServer::Server.new.build(backends, PuppetForgeServer::Utils::OptionParser.class_eval('@@DEFAULT_WEBUI_ROOT'))

