# Running talhelper with doppler

To generate config, I have put my env vars in a doppler config called 'talenv'
Below command will inject these env vars into talhelper

```
doppler run -p talenv -c prd talhelper genconfg
```
