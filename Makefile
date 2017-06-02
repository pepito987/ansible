.PHONY : all provision

all:
	$(error Usage: make <provision>)

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

ansible-provision:
	ansible-playbook playbooks/provision-playbook.yml -v