Ansible Mac Dev
===============

basic setup for Mac dev machine

Requirements
------------

-	xcode tools

	```
	    xcode-select --install
	```

- Python (via pyenv)

	NOTE: will need to pack old version of python (see https://github.com/pyenv/pyenv/issues/1746#issuecomment-780715744), because it doesn't support the changed link/library paths of Big Sur :(

	```
	brew install pyenv
	CFLAGS="-I$(brew --prefix openssl)/include -I$(brew --prefix bzip2)/include -I$(brew --prefix readline)/include -I$(xcrun --show-sdk-path)/usr/include" LDFLAGS="-L$(brew --prefix openssl)/lib -L$(brew --prefix readline)/lib -L$(brew --prefix zlib)/lib -L$(brew --prefix bzip2)/lib" pyenv install --patch 3.7.3 < <(curl -sSL https://github.com/python/cpython/commit/8ea6353.patch\?full_index\=1)
	```

-	Ansible 2.0

	```
	    pip3 install virtualenvwrapper
		export VIRTUALENVWRAPPER_PYTHON=~/.pyenv/versions/3.7.3/bin/python
		mkvirtualenv -p $(pyenv prefix 3.7.3)/bin/python ansible-mac-dev
		# Make sure virtual env is activated
	    pip install ansible==2.3.0.0 --user python
		# Or just pip install ansible
	```

Deploy
------

On MacOSX > Catalina, need to switch to bash as default shell `chsh -s /bin/bash`.


```
ansible-playbook -i localhost dev-setup.yml
```

### Post setup

Following the installation, open Vim and run

```
:PlugInstall
:GoInstall
```

### Vimrc

As this constantly changes, there is a useful 'vimrc' tag, to only update .vimrc

TODO
====

-	DNSMasq
