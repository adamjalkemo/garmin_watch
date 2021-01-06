# Garmin Watch development
Garmin watch app development

Getting started
https://developer.garmin.com/connect-iq/connect-iq-basics/getting-started/

Get the sdk:
https://developer.garmin.com/connect-iq/sdk/

Generate key:
```
openssl genrsa -out developer_key.pem 4096
openssl pkcs8 -topk8 -inform PEM -outform DER -in developer_key.pem -out developer_key.der -nocrypt
```

## Eclipse (optional)
Install eclipse:
```snap install eclipse```

Help->Install New Software
Add https://developer.garmin.com/downloads/connect-iq/eclipse

# Selecting the app to build
Either add options to make:
```
make APP=[appname] [recipe]
```
or set app in you shell
```
export APP=[appname]
```
where [appname] is one of:
* hello_world (default)
* low_heart_Rate_vibration

# Build
Build .prg:
```
make
```

# Simulate
```
make simulate
```

# Sideload
By copying .prg to GARMIN/APPS on watch
