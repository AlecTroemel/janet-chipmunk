(use jpm/cgen)

(def std-types {'int 'integer
                'float 'number})

(def libs-fns @{})
(var lib-name "")

(defn set-lib-name [name]
  (put libs-fns name @[@['NULL 'NULL 'NULL]] )
  (set lib-name name)
  nil)

(defmacro cfuns-entry []
  (def funsn (symbol lib-name '_cfuns))
  ~'((def (array ,funsn) JanetReg ,(libs-fns lib-name))))

(def pref '[JANET_MODULE_PREFIX JANET_API])

(defmacro module-imports []
  ~;(map |['@ 'include (string "\"" $ ".h\"")]
         (keys libs-fns)))

(defmacro module-entries []
  ~'((defn ,pref _janet_mod_config [] JanetBuildConfig
       (return (janet_config_current)))

     (defn [JANET_MODULE_PREFIX JANET_API] _janet_init [(env JanetTable*)] void
       ,;(map |['janet_cfuns 'env '"chipmunk" (symbol $ '_cfuns)]
              (keys libs-fns)))


    ))

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
  (array/insert (libs-fns lib-name)
                0 @[(string name) (symbol cname) (ndoc name doc bindings)])

  (var i 0)
  ~'((defn [static] ,cname [(argc int) (*argv Janet)] Janet
       (janet_fixarity argc ,arity)

       ,;(seq [[b-type b-name] :in bindings
               :let [b-name (match b-type
                              'cpBody (symbol '* b-name)
                                   'cpShape (symbol '* b-name)
                                   'cpSpace (symbol '* b-name)
                              _ b-name)
                     nt b-type
                     afn (match b-type
                           'cpBody ~(cp_getbody argv ,i)
                                'cpShape ~(cp_getshape argv ,i)
                                'cpSpace ~(cp_getspace argv ,i)
                           'cpVect ~(cp_getvec2 argv ,i)
                           _ ~(,(symbol 'janet_get (std-types nt)) argv ,i))]
               :after (++ i)]
              ~(def ,b-name ,nt ,afn))

       ,;(match result
          [r-type r-name]
          [['def (match r-type
                   'cpBody (symbol '* r-name)
                        'cpShape (symbol '* r-name)
                        'cpSpace (symbol '* r-name)
                   _ r-name)

            r-type [fn ;(map last bindings)]]
           ~(return ,(match r-type
                       'cpBody ~(cp_wrap_body ,r-name)
                            'cpShape ~(cp_wrap_shape ,r-name)
                            'cpSpace ~(cp_wrap_space ,r-name)
                       'cpVect ~(cp_wrap_vec2 ,r-name)
                       _ [(symbol 'janet_wrap_ (std-types r-type)) r-name]))]

          :nil
            [[fn ;(map last bindings)]
             '(return (janet_wrap_nil))]))))

(defmacro def-wrapper-abstract-type [name wtype]
  ~'((deft ,(symbol name 'Wrapper) (struct *handle ,wtype))
     # Get declaration
     (defn ,(symbol (string/ascii-lower name) '_get)
       [(*p void) (key Janet) (*out Janet)] int)

     # Put declaration
     (defn ,(symbol (string/ascii-lower name) '_put)
       [(*p void) (key Janet) (value Janet)] void)

     # Abstract class def
     (def [static const] ,(symbol 'AT_ name) JanetAbstractType
       (array ,(string "chipmunk/" name) NULL NULL
              ,(symbol (string/ascii-lower name) '_get)
              ,(symbol (string/ascii-lower name) '_put)
               JANET_ATEND_PUT))

     # cp_wrap_type
     (defn [static] ,(symbol 'cp_wrap_ (string/ascii-lower name)) [(*val ,wtype)] Janet
       (def *wrapper ,(symbol name 'Wrapper)
         (janet_abstract ,(symbol '&AT_ name) (sizeof ,(symbol name 'Wrapper))))
       (set (-> wrapper handle) val)
       (return (janet_wrap_abstract wrapper)))

     # cp_gettype
     (defn [static] ,(symbol 'cp_get (string/ascii-lower name)) [(*argv (const Janet)) (n int32_t)] ,(symbol wtype '*)
       (def *wrapper ,(symbol name 'Wrapper) (janet_getabstract argv n ,(symbol '&AT_ name)))
       (return (-> wrapper handle)))))
