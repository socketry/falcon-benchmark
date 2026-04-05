#!/usr/bin/env rackup
# frozen_string_literal: true

require_relative 'config/environment'

self.freeze_app

if UTOPIA.production?
	use Utopia::Exceptions::Handler
else
	# We want to propagate exceptions up when running tests:
	use Rack::ShowExceptions unless UTOPIA.testing?
end

# serve static files from public/
use Utopia::Static, root: 'public'

use Utopia::Redirection::Rewrite, {
	'/' => '/*'
}

use Utopia::Redirection::DirectoryIndex

use Utopia::Redirection::Errors, {
	404 => '/errors/file-not-found'
}

use Utopia::Controller

# serve static files from pages/
use Utopia::Static

# Serve dynamic content
use Utopia::Content

run lambda { |env| [404, {}, []] }
