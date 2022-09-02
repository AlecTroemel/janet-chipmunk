(use jpm/cgen)

(def std-types {'int 'integer
                'float 'number})

(var lib-name "")
(defn set-lib-name [name] (set lib-name name) nil)

(def fns @[@['NULL 'NULL 'NULL]])
(def pref '[JANET_MODULE_PREFIX JANET_API])
(defmacro cfuns-entry []
  (def funsn (symbol lib-name '_cfuns))
  ~'((def (array ,funsn) JanetReg ,fns)))

(defn- ndoc [name doc bindings]
  (string
   "(" name
   ;(if (not (empty? bindings))
      [" " (string/join (map last bindings) " ")] [])
   ")\n\n" doc))

(defmacro def-wrapper [name fn &named doc bindings result]
  (default result :nil)
  (def arity (length bindings))
  (def cname (string "cfun_" (string/replace-all "-" "_" name)))
  (array/insert fns 0 @[(string name) (symbol cname) (ndoc name doc bindings)])

  (var i 0)
  ~'((defn [static] ,cname [(argc int) (*argv Janet)] Janet
       (janet_fixarity argc ,arity)

       ,;(seq [[b-type b-name] :in bindings
               :let [b-name (match b-type
                              'cpBody (symbol '* b-name)
                              _ b-name)
                     nt b-type
                     afn (match b-type
                           'cpBody ~(cp_getbody argv ,i)
                           'cpVect ~(cp_getvec2 argv ,i)
                           _ ~(,(symbol 'janet_get (std-types nt)) argv ,i))]
               :after (++ i)]
              ~(def ,b-name ,nt ,afn))

       ,;(match result
          [r-type r-name]
          [['def (match r-type
                   'cpBody (symbol '* r-name)
                   _ r-name)

            r-type [fn ;(map last bindings)]]
           ~(return ,(match r-type
                       'cpBody ~(cp_wrap_body ,r-name)
                       'cpVect ~(cp_wrap_vec2 ,r-name)
                        _ (symbol 'janet_wrap (std-types r-type))))]

          :nil
            [[fn ;(map last bindings)]
             '(return (janet_wrap_nil))]))))
