
## Why doesn’t the **term** query match my document?

Teste:

```json
PUT my_index
{
  "mappings": {
    "my_type": {
      "properties": {
        "full_text": {
          "type":  "text" 
        },
        "exact_value": {
          "type":  "keyword" 
        }
      }
    }
  }
}

PUT my_index/my_type/1
{
  "full_text":   "Quick Foxes!", 
  "exact_value": "Quick Foxes!"  
}

Now, compare the results for the term query and the match query:

// This query matches because the exact_value field contains the exact term Quick Foxes!.
GET my_index/my_type/_search
{
  "query": {
    "term": {
      "exact_value": "Quick Foxes!" 
    }
  }
}

// This query does not match, because the full_text field only contains the terms quick and foxes. It does not contain the exact term Quick Foxes!.
GET my_index/my_type/_search
{
  "query": {
    "term": {
      "full_text": "Quick Foxes!" 
    }
  }
}

// A term query for the term foxes matches the full_text field.
GET my_index/my_type/_search
{
  "query": {
    "term": {
      "full_text": "foxes" 
    }
  }
}

// This match query on the full_text field first analyzes the query string, then looks for documents containing quick or foxes or both.
GET my_index/my_type/_search
{
  "query": {
    "match": {
      "full_text": "Quick Foxes!" 
    }
  }
}

```


Referência: https://www.elastic.co/guide/en/elasticsearch/reference/5.4/query-dsl-term-query.html