#!/usr/bin/env bb

(require '[babashka.process :refer [shell process exec]])

(let [code_extensions (-> (slurp "./code_extensions.txt")
                          (str/split-lines)
                          (set))
      installed_extensions (->  (shell {:out :string} "code" "--list-extensions")
                                (:out)
                                (str/split-lines)
                                (set))
      uninstalled_extensions (set/difference code_extensions installed_extensions)]
  (if (empty? uninstalled_extensions)
    (println "no extensions to install!")
    (println "found" (count uninstalled_extensions) "extensions.")
    ;; (println (first uninstalled_extensions))
    ;; (println "found" (count uninstalled_extensions) "extensions.")
    )
  (dorun (for [ext (sort uninstalled_extensions)]
           (do (println "Installing " ext "...")
               (shell "code" "--install-extension" ext)))))


