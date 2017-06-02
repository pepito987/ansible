.PHONY : all provision destroy

all:
	$(error Usage: make <provision, destroy >)

docker-check:
	@if docker info > /dev/null; then \
		echo "=== Using Docker ==="; \
	else \
		echo "=== Docker is not working, cannot proceed ==="; \
		exit 1; \
	fi

.dockerignore: requirements.txt Dockerfile
	@echo "=== dependencies updated, hence rebuilding docker image ==="
	@docker-compose build
	@touch .dockerignore

provivion: docker-check .dockerignore
	docker-compose run --rm with make ansible-provision

destroy: docker-check .dockerignore
	docker-compose run --rm with make ansible-destroy

test-create: docker-check .dockerignore
	docker-compose run --rm with bundle exec rake spec\[create\]

test-destroy: docker-check .dockerignore
	docker-compose run --rm with bundle exec rake spec\[destroy\]

ansible-provision:
	ansible-playbook playbooks/provision-playbook.yml -v

ansible-destroy:
	ansible-playbook playbooks/destroy-playbook.yml -v
