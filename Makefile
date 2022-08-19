include config.env

enviroment_var:
	cd ./aws; export $AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY); \
		export $AWS_ACCESS_KEY_ID$(AWS_ACCESS_KEY_ID);