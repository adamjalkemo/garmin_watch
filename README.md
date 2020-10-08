# garmin_watch
Garmin watch app development

Get the sdk:
https://developer.garmin.com/connect-iq/sdk/

Generate key:
```
openssl genrsa -out developer_key.pem 4096
openssl pkcs8 -topk8 -inform PEM -outform DER -in developer_key.pem -out developer_key.der -nocrypt
```

Install eclipse:
```snap install eclipse```

Help->Install New Software
Add https://developer.garmin.com/downloads/connect-iq/eclipse

```
export PATH=$PATH:~/.Garmin/ConnectIQ/Sdks/connectiq-sdk-lin-3.2.2-2020-08-28-a50584d55/bin

make
```