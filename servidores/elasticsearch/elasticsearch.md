---
view: elasticsearch
title: Comandos do Elastic
description: Vários comandos do elasticsearch
---

* [Elasticsearch](#elasticsearch)
  * [Instalação](#instala-o)
  * [Lista de Comandos Diversos](#lista-de-comandos-diversos)
* [Agregação](#agrega-o)
  * [Clusters](#clusters)
    * [Cache](#cache)
* [CRUD](#crud)
  * [Create](#create)
  * [Remove](#remove)
  * [Update](#update)
  * [Delete](#delete)
    * [Nodes](#nodes)
  * [CRUD \(Trabalhando com dados\)](#crud-trabalhando-com-dados)
    * [Create](#create)
    * [Remove](#remove)
    * [Update](#update)
    * [Delete](#delete)
  * [Índices](#ndices)
  * [Mapping](#mapping)
  * [Monitoramento](#monitoramento)
  * [Plugins](#plugins)
  * [Renomear \(reindexar\)](#renomear-reindexar)
  * [Settings](#settings)
  * [Search](#search)
  * [Template](#template)
* [Referências](#refer-ncias)
* [TODO: Ler](#todo-ler)

# Elasticsearch

## Instalação

## Lista de Comandos Diversos

GET /_all  
GET /_cat  
GET /_cat/allocation?v  
GET /_cat/health?v  
GET /_cat/shards?v  
GET /_cat/indices?v  
GET /_cat/templates?v&s=name  
GET /_cat/master?v  
GET /_cat/thread/_pool/generic?v&h=id,name,active,rejected,completed  
GET /_cat/segments?v  
GET /_cat/plugins?v&s=component&h=name,component,version,description  
GET /_cat/recovery?v  
GET /_nodes/stats  
GET /_search  
GET /_scripts  
GET /_segments  
GET /_settings  
GET /_mapping  
GET /_stats  
GET /_status  
GET /_cluster/state  
GET /_cluster/health  
GET /_cluster/health?level=indices  
GET /_cluster/health?level=shards  
GET /_cluster/health?wait/_for/_status=green  
GET /_cluster/state?ignore/_unavailable=true  
GET /_cluster/settings  
GET /_refresh  
GET /_tasks?wait/_for/_completion=true&timeout=10s  
GET /_nodes?filter/_path=\*\*.mlockall  
GET /_nodes/stats//_all  
POST /_forcemerge?only/_expunge/_deletes=true

# Agregação

## Clusters

### Cache

```json
# Limpar caches
POST /_cache/clear
```

# CRUD

## Create

## Remove

## Update

## Delete

### Nodes

```json
GET /_nodes/stats/indices
GET /_nodes/stats/os,process
```

## CRUD \(Trabalhando com dados\)

### Create

### Remove

### Update

### Delete

## Índices

```json
# Listar indices ordenadamente
GET _cat/indices?v&s=index:asc
GET _cat/indices/nome-do-indice?v&s=index:asc


# Apagar
DELETE nome-do-indice
DELETE indice1,indice2,indice3,...
```

## Mapping

```json
# Listar todos mapeamentos de todos índices
GET _mapping
```

## Monitoramento

* X-Pack vem com algumas características-chave para monitorar o Elastic Stack. Não há melhor maneira de monitorar o Elastic Stack.
* [http://www.elastichq.org/features.html](http://www.elastichq.org/features.html) \(precisa CORS configurado no servidor elasticsearch\)

## Plugins

* bin/elasticsearch-plugin install x-pack
* bin/elasticsearch-plugin install analysis-phonetic
* bin/elasticsearch-plugin install ingest-attachment
* bin/elasticsearch-plugin install ingest-geoip
* bin/elasticsearch-plugin install ingest-user-agent

```json
# Listar todos plugins
GET _cat/plugins?v&s=component&h=name,component,version,description
```

## Renomear \(reindexar\)

```json
POST /_reindex
{
    "source": {
        "index": "indexOriginal"
    },
    "dest": {
        "index": "indexNovo"
    }
}
```

## Settings

```json
# Obter todas configurações de todos os índices
GET _settings
```

## Search

## Template

```json
GET _template/mainframe
{
      "order": 0,
      "version": 20170608,
      "template": "mf_*",
      "settings": {
         "index": {
            "refresh_interval": "2s",
            "analysis": {
               "filter": {
                  "my_ascii_folding": {
                     "type": "asciifolding",
                     "preserve_original": "true"
                  },
                  "portuguese_keywords": {
                     "keywords": [
                        "exemplo"
                     ],
                     "type": "keyword_marker"
                  },
                  "portuguese_stop": {
                     "type": "stop",
                     "stopwords": "_portuguese_"
                  },
                  "my_metaphone": {
                     "replace": "false",
                     "type": "phonetic",
                     "encoder": "metaphone"
                  },
                  "portuguese_stemmer": {
                     "type": "stemmer",
                     "language": "light_portuguese"
                  }
               },
               "analyzer": {
                  "default": {
                     "filter": [
                        "standard",
                        "lowercase",
                        "my_metaphone",
                        "my_ascii_folding"
                     ],
                     "tokenizer": "standard"
                  },
                  "portuguese": {
                     "filter": [
                        "lowercase",
                        "my_metaphone",
                        "portuguese_stop",
                        "portuguese_keywords",
                        "portuguese_stemmer"
                     ],
                     "tokenizer": "standard"
                  }
               }
            },
            "number_of_shards": "10",
            "number_of_replicas": "1"
         }
      },
      "mappings": {
         "_default_": {
            "_source": {
               "enabled": true
            },
            "_all": {
               "enabled": false
            },
            "properties": {
               "data_modificacao": {
                  "format": "yyyyMMddHHmmss",
                  "type": "date"
               },
               "filename": {
                  "type": "text"
               },
               "attachment": {
                  "properties": {
                     "content": {
                        "analyzer": "portuguese",
                        "type": "text"
                     }
                  }
               },
               "indice_custom": {
                  "type": "text"
               },
               "ocr_text": {
                  "type": "text"
               },
               "restricao_acesso": {
                  "type": "text",
                  "fields": {
                     "keyword": {
                        "ignore_above": 256,
                        "type": "keyword"
                     }
                  }
               },
               "data_indexacao": {
                  "format": "yyyyMMddHHmmss",
                  "type": "date"
               }
            }
         }
      },
      "aliases": {}
   }
```

# Referências

* [https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html](https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html)
* [http://david.pilato.fr/blog/2015/05/09/advanced-search-for-your-legacy-application/](http://david.pilato.fr/blog/2015/05/09/advanced-search-for-your-legacy-application/)

# TODO: Ler

* [https://www.datadoghq.com/blog/monitor-elasticsearch-performance-metrics/](https://www.datadoghq.com/blog/monitor-elasticsearch-performance-metrics/)
* [https://www.datadoghq.com/blog/elasticsearch-performance-scaling-problems/](https://www.datadoghq.com/blog/elasticsearch-performance-scaling-problems/)
* [https://www.datadoghq.com/blog/collect-elasticsearch-metrics/](https://www.datadoghq.com/blog/collect-elasticsearch-metrics/)
* [https://www.opsdash.com/blog/howto-setup-elasticsearch-secure.html](https://www.opsdash.com/blog/howto-setup-elasticsearch-secure.html)



