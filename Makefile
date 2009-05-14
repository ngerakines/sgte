LIBDIR=`erl -eval 'io:format("~s~n", [code:lib_dir()])' -s init stop -noshell`
VERSION=0.7.1

all:
	mkdir -p ebin/
	(cd src;$(MAKE))

clean:
	(cd src;$(MAKE) clean)
	rm -rf erl_crash.dump *.beam *.hrl

package: clean
	@mkdir sgte-$(VERSION)/ && cp -rf _build.cfg CHANGELOG ebin conf doc Makefile sgte.pub src test sgte-$(VERSION)
	@COPYFILE_DISABLE=true tar zcf sgte-$(VERSION).tgz sgte-$(VERSION)
	@rm -rf sgte-$(VERSION)/

install:
	mkdir -p $(prefix)/$(LIBDIR)/sgte-$(VERSION)/ebin
	for i in ebin/*.beam; do install $$i $(prefix)/$(LIBDIR)/sgte-$(VERSION)/$$i ; done
