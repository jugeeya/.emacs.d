(setq msc-highlights
      '(
        ("\\\#.*" . font-lock-comment-face)
        ("\\b\\(nop\\|begin\\|end\\|jump4\\|jump5\\|return_6\\|return_7|return_8\\|return_9\\|pushInt\\|pushVar\\|error_C\\|pushShort\\|addi\\|subi\\|multi\\|divi\\|modi\\|negi\\|i\++\\|i--\\|bitAnd\\|bitOr\\|bitNot\\|bitXor\\|leftShift\\|rightShift\\|setVar\\|i\+=\\|i-=\\|i\*=\\|i/=\\|i%=\\|i&=\\|i\|=\\|i^=\\|equals\\|notEquals\\|notEqual\\|lessThan\\|lessOrEqual\\|greater\\|greaterOrEqual\\|not\\|printf\\|sys\\|try\\|unk_2E\\|callFunc\\|callFunc2\\|callFunc3\\|push\\|pop\\|if\\|ifNot\\|else\\|error_37\\|intToFloat\\|floatToInt\\|addf\\|subf\\|multf\\|divf\\|negf\\|f\++\\|f--\\|floatVarSet\\|float\+=\\|float-=\\|float\*=\\|float/=\\|floatGreater\\|floatLessOrEqual\\|floatLess\\|floatNotEqual\\|floatEqual\\|floatGreaterOrEqual\\|error_4c\\|exit\\|byte\\|long\\)\\\." . font-lock-string-face)
        ("\\b\\(nop\\|begin\\|end\\|jump4\\|jump5\\|return_6\\|return_7|return_8\\|return_9\\|pushInt\\|pushVar\\|error_C\\|pushShort\\|addi\\|subi\\|multi\\|divi\\|modi\\|negi\\|i\\++\\|i--\\|bitAnd\\|bitOr\\|bitNot\\|bitXor\\|leftShift\\|rightShift\\|setVar\\|i\\+=\\|i-=\\|i\\*=\\|i/=\\|i%=\\|i&=\\|i\|=\\|i^=\\|equals\\|notEquals\\|notEqual\\|lessThan\\|lessOrEqual\\|greater\\|greaterOrEqual\\|not\\|printf\\|sys\\|try\\|unk_2E\\|callFunc\\|callFunc2\\|callFunc3\\|push\\|pop\\|if\\|ifNot\\|else\\|error_37\\|intToFloat\\|floatToInt\\|addf\\|subf\\|multf\\|divf\\|negf\\|f\\+\\+\\|f--\\|floatVarSet\\|float\\+=\\|float-=\\|float\\*=\\|float/=\\|floatGreater\\|floatLessOrEqual\\|floatLess\\|floatNotEqual\\|floatEqual\\|floatGreaterOrEqual\\|error_4c\\|exit\\|byte\\|long\\)" . font-lock-function-name-face)
        ("\\b\\(\\(\\([0-9\\_]+\\.[0-9\\_]*\\(f\\)\\)\\(e[+-]?[0-9\\_]+\\)?\\|\\.?[0-9\\_]+e[+-]?[0-9\\_]+\\)\\)\\b" . font-lock-type-face)
        ("\\b0x[0-9a-fA-F\\_]+\\b" . font-lock-type-face)
        ("\\b[A-Za-z0-9_:]+\\b" . font-lock-keyword-face)
        ("\\b\\:" . font-lock-keyword-face)
        )
      )

(define-derived-mode msc-mode fundamental-mode "msc"
  "major mode for editing mymath language code."
  (setq font-lock-defaults '(msc-highlights)))

(add-to-list 'auto-mode-alist '("\\.mscscript\\'" . msc-mode))
