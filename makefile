
build = $(shell pwd)/build
all:openwrt android linux android windows

openwrt:
	mkdir -p $(build)/openwrt
	GOOS=linux GOARCH=mipsle GOMIPS=softfloat CGO_ENABLED=0   go build -o $(build)/openwrt/v2ray -trimpath -ldflags "-s -w -buildid=" ./main

linux:
	mkdir -p $(build)/linux
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0   go build -o $(build)/linux/v2ray -trimpath -ldflags "-s -w -buildid=" ./main

arm:
	mkdir -p $(build)/linux
	GOOS=linux GOARCH=arm64 CGO_ENABLED=0   go build -o $(build)/arm/v2ray -trimpath -ldflags "-s -w -buildid=" ./main

windows:
	mkdir -p $(build)/windows
	GOOS=windows GOARCH=amd64 CGO_ENABLED=0   go build -o $(build)/windows/v2ray.exe -trimpath -ldflags "-s -w -buildid=" ./main

osx:
	mkdir -p $(build)
	GOOS=darwin GOARCH=amd64 CGO_ENABLED=0   go build -o $(build)/osx/v2ray -trimpath -ldflags "-s -w -buildid=" ./main

android:
	mkdir -p $(build)
	GOOS=linux GOARCH=arm  CGO_ENABLED=0   go build -o $(build)/android/v2ray -trimpath -ldflags "-s -w -buildid=" ./main

auto:
	mkdir -p $(build)
	./user-package.sh linux 386 nosource noconf codename=happyday

down:
	mkdir -p $(build)
	echo ">>> Download latest geoip.dat"
	curl -s   -L -o $(build)/geoip.dat "https://github.com/v2fly/geoip/raw/release/geoip.dat"

	echo ">>> Download latest geoip-only-cn-private.dat"
	curl -s   -L -o $(build)/geoip-only-cn-private.dat "https://github.com/v2fly/geoip/raw/release/geoip-only-cn-private.dat"

	echo ">>> Download latest geosite.dat"
	curl -s   -L -o $(build)/geosite.dat "https://github.com/v2fly/domain-list-community/raw/release/dlc.dat"
