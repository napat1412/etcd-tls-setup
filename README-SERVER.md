cfssl gencert -initca json/ca-csr.json | cfssljson -bare ca -
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=json/ca-config.json -profile=peer json/etcd1.json | cfssljson -bare etcd1
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=json/ca-config.json -profile=client json/client.json | cfssljson -bare client
 
etcd --name infra0 --data-dir infra0 \
  --client-cert-auth --trusted-ca-file=/etc/etcd/tls-setup/certs/ca.pem \
  --cert-file=/etc/etcd/tls-setup/certs/etcd1.pem \
  --key-file=/etc/etcd/tls-setup/certs/etcd1-key.pem \
  --advertise-client-urls https://127.0.0.1:2379 --listen-client-urls https://127.0.0.1:2379

curl --cacert /etc/etcd/tls-setup/certs/ca.pem --cert /etc/etcd/tls-setup/certs/client.pem \
   --key /etc/etcd/tls-setup/certs/client-key.pem https://localhost:2379/v2/keys/foo -XPUT -d value=bar -v

