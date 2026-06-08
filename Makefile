CORE        := -f compose.yaml
STORAGE     := -f compose.storage.yaml
OBS         := -f compose.observability.yaml
LLM         := -f compose.llm.yaml
PORTAINER   := -f compose.portainer.yaml
# NGINX excluded from ALL until services/nginx is implemented
NGINX       := -f compose.nginx.yaml

ALL         := $(CORE) $(STORAGE) $(OBS) $(LLM) $(PORTAINER)

SOPS_DEV  = eval "$$(sops --input-type dotenv --output-type dotenv -d .env.dev  2>/dev/null | grep '=' | sed 's/^/export /')" &&
SOPS_PROD = eval "$$(sops --input-type dotenv --output-type dotenv -d .env.prod 2>/dev/null | grep '=' | sed 's/^/export /')" &&

.PHONY: core core-prod observability observability-prod llm llm-prod full full-prod down ps logs

core:
	$(SOPS_DEV) docker compose $(CORE) $(STORAGE) up -d

core-prod:
	$(SOPS_PROD) docker compose $(CORE) $(STORAGE) up -d

observability:
	$(SOPS_DEV) docker compose $(CORE) $(STORAGE) $(OBS) up -d

observability-prod:
	$(SOPS_PROD) docker compose $(CORE) $(STORAGE) $(OBS) up -d

llm:
	$(SOPS_DEV) docker compose $(CORE) $(STORAGE) $(LLM) up -d

llm-prod:
	$(SOPS_PROD) docker compose $(CORE) $(STORAGE) $(LLM) up -d

full:
	$(SOPS_DEV) docker compose $(ALL) up -d

full-prod:
	$(SOPS_PROD) docker compose $(ALL) up -d

down:
	$(SOPS_DEV) docker compose $(ALL) down

ps:
	$(SOPS_DEV) docker compose $(ALL) ps

logs:
	$(SOPS_DEV) docker compose $(ALL) logs -f
