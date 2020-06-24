setup:
	python3 -m venv ~/.capstone
install:
	# This should be run from inside a virtualenv
	pip install --upgrade pip &&\
		pip install -r requirements.txt

	wget -O ./hadolint https://github.com/hadolint/hadolint/releases/download/v1.18.0/hadolint-Linux-x86_64 && chmod +x ./hadolint && sudo mv ./hadolint /bin
	
start:
	python3 ./src/app.py