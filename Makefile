.PHONY: cfssl ca req clean

CFSSL   = ./bin/cfssl
JSON    = ./bin/cfssljson

#Generate Root CA & Req certification
all: ca req
#Generate only Req certification
#all: req

ca:
	mkdir -p certs
	$(CFSSL) gencert -initca config/ca-csr.json | $(JSON) -bare certs/ca

req:
	$(CFSSL) gencert \
	  -ca certs/ca.pem \
	  -ca-key certs/ca-key.pem \
	  -config config/ca-config.json \
	  -profile=peer \
	  config/req-peer.json | $(JSON) -bare certs/etcd1
	$(CFSSL) gencert \
	  -ca certs/ca.pem \
	  -ca-key certs/ca-key.pem \
	  -config config/ca-config.json \
	  -profile=peer \
	  config/req-peer.json | $(JSON) -bare certs/etcd2
	$(CFSSL) gencert \
	  -ca certs/ca.pem \
	  -ca-key certs/ca-key.pem \
	  -config config/ca-config.json \
	  -profile=peer \
	  config/req-peer.json | $(JSON) -bare certs/etcd3
	$(CFSSL) gencert \
	  -ca certs/ca.pem \
	  -ca-key certs/ca-key.pem \
	  -config config/ca-config.json \
	  -profile=peer \
	  config/req-peer.json | $(JSON) -bare certs/etcd4
	$(CFSSL) gencert \
	  -ca certs/ca.pem \
	  -ca-key certs/ca-key.pem \
	  -config config/ca-config.json \
	  -profile=peer \
	  config/req-peer.json | $(JSON) -bare certs/etcd5
	$(CFSSL) gencert \
	  -ca certs/ca.pem \
	  -ca-key certs/ca-key.pem \
	  -config config/ca-config.json \
	  -profile=peer \
	  config/req-peer.json | $(JSON) -bare certs/proxy
	$(CFSSL) gencert \
	  -ca certs/ca.pem \
	  -ca-key certs/ca-key.pem \
	  -config config/ca-config.json \
	  -profile=client \
	  config/req-peer.json | $(JSON) -bare certs/client-apiserver
	$(CFSSL) gencert \
	  -ca certs/ca.pem \
	  -ca-key certs/ca-key.pem \
	  -config config/ca-config.json \
	  -profile=client \
	  config/req-peer.json | $(JSON) -bare certs/client

clean:
	rm -rf certs

