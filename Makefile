include config.env

.PHONY: env
.DEFAULT_GOAL := env

iam_user:
	cd ./aws/iam; \
		export AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID); \
		export AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY);
		terraform 

env:
	cd ./aws; \
		export AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID); \
		export AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY); \
