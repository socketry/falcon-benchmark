# frozen_string_literal: true

# Build all benchmark containers.
def build
	system("docker compose build")
end

# Run the full benchmark suite and write results to results/data/.
def benchmark
	system("docker compose up --abort-on-container-exit test")
end

# Tear down all containers.
def clean
	system("docker compose down --remove-orphans")
end

def server
	Bundler.with_unbundled_env do
		system("bundle exec falcon serve", chdir: "results")
	end
end
