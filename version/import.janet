(import http)
(import json)


(def url "https://search.maven.org/solrsearch/select?q=a:clojure&start=0&rows=20")
(def response (http/get url))
(def data (if (= (get response :status) 200)
            (json/decode (get response :body) true true)
            (do (printf "Unexpected result from %s\n%q" url response)
                {:response {:docs[{:latestVersion "unknown"
                                   :timestamp 0}]}})))

(def result {:name (get-in data [:response :docs 0 :latestVersion])
             :published-at (/ (get-in data [:response :docs 0 :timestamp])
                              1000)})

(with [f (file/open "version.json" :w)]
  (file/write f (json/encode result)))
