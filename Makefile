export UDIR= .
export GOC = x86_64-xen-ethos-6g
export GOL = x86_64-xen-ethos-6l
export ETN2GO = etn2go
export ET2G   = et2g
export EG2GO  = eg2go

export GOARCH = amd64
export TARGET_ARCH = x86_64
export GOETHOSINCLUDE=/usr/lib64/go/pkg/ethos_$(GOARCH)
export GOLINUXINCLUDE=/usr/lib64/go/pkg/linux_$(GOARCH)


install.rootfs = /var/lib/ethos/ethos-default-$(TARGET_ARCH)/rootfs
install.minimaltd.rootfs = /var/lib/ethos/minimaltd/rootfs


.PHONY: all install
all: Boxprog

install: Boxprog
	ethosTypeInstall $(install.rootfs) $(install.minimaltd.rootfs) Box
	install Boxprog $(install.rootfs)/programs
	install Boxprog $(install.minimaltd.rootfs)/programs
	echo -n /programs/Boxprog | ethosStringEncode > $(install.rootfs)/etc/init/console
	mkdir -p $(install.rootfs)/user/nobody/myDir
	setfattr -n user.ethos.typeHash -v $(shell egPrint Box hash Box) $(install.rootfs)/user/nobody/myDir
	

Box.go: Box.t
	$(ETN2GO) . Box main $^
Boxprog: Boxprog.go Box.go
	ethosGo $^ 

clean:
	rm -rf Box/ BoxIndex/
	rm -f Box.go
	rm -f Boxprog
	rm -f Boxprog.goo.ethos
