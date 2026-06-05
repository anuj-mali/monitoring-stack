CORE        := -f compose.yaml
STORAGE     := -f compose.storage.yaml
OBS         := -f compose.observability.yaml
LLM         := -f compose.llm.yaml
PORTAINER   := -f compose.portainer.yaml
# NGINX excluded from ALL until services/nginx is implemented (empty stub)
NGINX       := -f compose.nginx.yaml

ALL         := $(CORE) $(STORAGE) $(OBS) $(LLM) $(PORTAINER)

DEV_ENV     := ENV_FILE=.env.dev
PROD_ENV    := ENV_FILE=.env.prod

.PHONY: core core-prod observability observability-prod llm llm-prod full full-prod down ps logs

core:
	$(DEV_ENV) docker compose $(CORE) $(STORAGE) up -d

core-prod:
	$(PROD_ENV) docker compose $(CORE) $(STORAGE) up -d

observability:
	$(DEV_ENV) docker compose $(CORE) $(STORAGE) $(OBS) up -d

observability-prod:
	$(PROD_ENV) docker compose $(CORE) $(STORAGE) $(OBS) up -d

llm:
	$(DEV_ENV) docker compose $(CORE) $(STORAGE) $(LLM) up -d

llm-prod:
	$(PROD_ENV) docker compose $(CORE) $(STORAGE) $(LLM) up -d

full:
	$(DEV_ENV) docker compose $(ALL) up -d

full-prod:
	$(PROD_ENV) docker compose $(ALL) up -d

down:
	$(DEV_ENV) docker compose $(ALL) down

ps:
	$(DEV_ENV) docker compose $(ALL) ps

logs:
	$(DEV_ENV) docker compose $(ALL) logs -f
