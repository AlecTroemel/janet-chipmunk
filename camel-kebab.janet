(def camelCasePeg
  (peg/compile ~{:low-word (* (% (<- (some (range "az" "09"))))
                              (to (range "AZ")))
                 :cap-word (% (* (<- (range "AZ"))
                                 (some (<- (range "az" "09")))))
                 :main (* :low-word (any :cap-word))}))

(defn camel-to-kebab [str]
  (string/join
   (->> str
        (peg/match camelCasePeg)
        (map string/ascii-lower))
   "-"))
