/-
Copyright (c) 2021-2023 by the authors listed in the file AUTHORS and their
institutional affiliations. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Abdalrhman Mohamed
-/

import Lean
import Std.Data.Rat
import Smt.Translator

namespace Smt.Rat

open Lean Expr
open Translator Term

@[smtTranslator] def replaceConst : Translator
  | const `Rat _      => return symbolT "Real"
  | const ``Rat.add _ => return symbolT "+"
  | const ``Rat.sub _ => return symbolT "-"
  | const ``Rat.neg _ => return symbolT "-"
  | const ``Rat.mul _ => return symbolT "*"
  | const ``Rat.div _ => return symbolT "div"
  | const ``Rat.lt _  => return symbolT "<"
  | const ``Rat.blt _ => return symbolT "<"
  | app (app (const ``LE.le _) (const `Rat _)) _ => return symbolT "<="
  | app (app (const ``GT.gt _) (const `Rat _)) _ => return symbolT ">"
  | app (app (const ``GE.ge _) (const `Rat _)) _ => return symbolT ">="
  | app (app (app (const ``Int.cast _) (const `Rat _)) _) e => applyTranslators! e
  | _ => return none

end Smt.Rat
