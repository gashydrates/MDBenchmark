.PHONY: build clean clean-build clean-pyc clean-test upload reformat reformat-check flake8 isort isort-check lint rst-lint
clean: clean-build clean-pyc clean-test

clean-build:
	rm -rf build/
	rm -rf dist/

clean-pyc:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -rf {} +

clean-test:
	rm -rf .tox/
	rm -f .coverage
	rm -rf htmlcov/
	rm -rf .pytest_cache/

build: clean
	python setup.py sdist bdist_wheel --universal

upload: build
	twine upload dist/*

reformat:
	black setup.py mdbenchmark/

reformat-check:
	black --check setup.py mdbenchmark/ docs/

flake8:
	flake8 mdbenchmark/

isort:
	isort -y

isort-check:
	isort --check-only --diff

lint: reformat-check flake8 isort-check

rst-lint:
	rst-lint README.rst CHANGELOG.rst DEVELOPER.rst
