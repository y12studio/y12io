How to test redis+ELK

```
sudo fig build
sudo fig up -d
sudo fig logs
```

kibana http://host:9280/

elasticsearch http://host:9200/

plugin head http://host:9200/_plugin/head/

plugin HQ http://host:9200/_plugin/HQ/