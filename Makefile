.PHONY: cfssl ca req clean

CFSSL   = ./bin/cfssl
JSON    = ./bin/cfssljson

#Generate Root CA & Req certification
all: ca req
#Generate only Req certification
#all: req

ca:
	mkdir -p certs
	$(CFSSL) gencert -initca config/ca-csr.json | $(JSON) -bare certs/ca -

req:
	$(CFSSL) gencert \
          -ca=certs/ca.pem \
          -ca-key=certs/ca-key.pem \
          -config=config/ca-config.json \
          -profile=client config/client.json | $(JSON) -bare certs/client
	$(CFSSL) gencert \
          -ca=certs/ca.pem \
          -ca-key=certs/ca-key.pem \
          -config=config/ca-config.json \
          -profile=server config/peer-ms01.json | $(JSON) -bare certs/s-ms01
	$(CFSSL) gencert \
          -ca=certs/ca.pem \
          -ca-key=certs/ca-key.pem \
          -config=config/ca-config.json \
          -profile=peer config/peer-ms01.json | $(JSON) -bare certs/p-ms01
	$(CFSSL) gencert \
          -ca=certs/ca.pem \
          -ca-key=certs/ca-key.pem \
          -config=config/ca-config.json \
          -profile=server config/peer-ms02.json | $(JSON) -bare certs/s-ms02
	$(CFSSL) gencert \
          -ca=certs/ca.pem \
          -ca-key=certs/ca-key.pem \
          -config=config/ca-config.json \
          -profile=peer config/peer-ms02.json | $(JSON) -bare certs/p-ms02
        $(CFSSL) gencert \
          -ca=certs/ca.pem \
          -ca-key=certs/ca-key.pem \
          -config=config/ca-config.json \
          -profile=server config/peer-ms03.json | $(JSON) -bare certs/s-ms03
        $(CFSSL) gencert \
          -ca=certs/ca.pem \
          -ca-key=certs/ca-key.pem \
          -config=config/ca-config.json \
          -profile=peer config/peer-ms03.json | $(JSON) -bare certs/p-ms03
        $(CFSSL) gencert \
          -ca=certs/ca.pem \
          -ca-key=certs/ca-key.pem \
          -config=config/ca-config.json \
          -profile=server config/peer-ms04.json | $(JSON) -bare certs/s-ms04
        $(CFSSL) gencert \
          -ca=certs/ca.pem \
          -ca-key=certs/ca-key.pem \
          -config=config/ca-config.json \
          -profile=peer config/peer-ms04.json | $(JSON) -bare certs/p-ms04
        $(CFSSL) gencert \
          -ca=certs/ca.pem \
          -ca-key=certs/ca-key.pem \
          -config=config/ca-config.json \
          -profile=server config/peer-ms05.json | $(JSON) -bare certs/s-ms05
        $(CFSSL) gencert \
          -ca=certs/ca.pem \
          -ca-key=certs/ca-key.pem \
          -config=config/ca-config.json \
          -profile=peer config/peer-ms05.json | $(JSON) -bare certs/p-ms05


clean:
	rm -rf certs

