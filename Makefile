# developer utilities

.PHONY: docs apidocs pylint

docs:
	$(MAKE) -C master/docs

apidocs:
	$(MAKE) -C apidocs

pylint:
	$(MAKE) -C master pylint; master_res=$$?; \
	$(MAKE) -C slave pylint; slave_res=$$?; \
	if [ $$master_res != 0 ] || [ $$slave_res != 0 ]; then exit 1; fi

pyflakes:
	pyflakes master/buildbot slave/buildslave

pep8:
	pep8 --config=common/pep8rc master/buildbot slave/buildslave www/*/buildbot_*/ www/*/setup.py

frontend:
	for i in www/*/; do pip install -e $$i ; done

rmpyc:
	find . \( -name '*.pyc' -o -name '*.pyo' \) -exec rm -v {} \;
