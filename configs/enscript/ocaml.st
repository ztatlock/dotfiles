/**
 * Name: ocaml
 * Description: Objective Caml programming language.
 *
 * Simple highlighting for keywords, comments and strings.
 * Does not handle nested comments.
 *
 * Regexp's mostly borrowed from caml-mode.
 *
 * Author: Janne Hellsten <jjhellst@gmail.com>
 * Date: 2005-05-21
 */

/* A-Z \192-\214\216-\222]";*/
upper = "[A-Z]";
lower = "[a-z]";
ident_char = concat("(", upper, "|", lower, "|", "[0-9_\'])");

module_ident = concat("(\\b|\\.)((", upper, ")+", ident_char, "*)\\b");
module_ident_re = 0;

module_qual = concat("((", upper, ")+", ident_char, "*)\\.");
module_qual_re = 0;

polymorphic_var = concat("(`(", "(", ident_char, ")+))");
polymorphic_var_re = 0;

var_ident = concat("(", lower, "|", "[0-9_\'])+", ident_char,"*");
var_ident_re = 0;
 
state ocaml extends HighlightEntry
{
  BEGIN {
    module_ident_re    = regexp (module_ident);
    module_qual_re     = regexp (module_qual);
    polymorphic_var_re = regexp (polymorphic_var);
    var_ident_re 	   = regexp (var_ident);
  }

  /* Comments. */
  /\(\*/ {
    comment_face (true);
    language_print ($0);
    call (ocaml_comment);
    comment_face (false);
  }

  /* String constants. */
  /\"/ {
    string_face (true);
    language_print ($0);
    call (ocaml_string);
    string_face (false);
  }

  /* Character constants. */
  /('[^']+')/ {                /*'*/
    string_face (true);
    language_print ($1);
    string_face (false);
  }

  /\b(assert|open|include)\b/ {
    builtin_face (true);
    language_print ($0);
    builtin_face (false);
  }

  /\b(a(nd|s)|c(onstraint|lass)|ex(ception|ternal)|fun(ct(ion|or))?|in(herit)?|let|m(ethod|utable|odule)|of|p(arser|rivate)|rec|type|v(al|irtual))\b/ {
    /* Definitions  */
    keyword_face (true);
    language_print ($0);
    keyword_face (false);
  }

  /\b(do(ne|wnto)?|else|for|i(f|gnore)|lazy|match|new|or|t(hen|o|ry)|w(h(en|ile)|ith))\b/ {
    /* Control */
    keyword_face (true);
    language_print ($0);
    keyword_face (false);
  }

  /\b(object|struct|sig|begin|end)\b/ {
    /* Blocks */
    keyword_face (true);
    language_print ($1);
    keyword_face (false);
  }

  var_ident_re {
    variable_name_face (true);
    language_print ($0);
    variable_name_face (false);
  }

  /* Modules */
  module_qual_re {
    reference_face (true);
    language_print ($1);
    reference_face (false);
    language_print (".");
  }

  module_ident_re {
    language_print ($1);
    type_face (true);
    language_print ($2);
    type_face (false);
  }

  polymorphic_var_re {
    language_print ("`");
    type_face (true);
    language_print ($2);
    type_face (false);
  }


}

state ocaml_comment extends Highlight
{
  /\*\)/ {
    language_print ($0);
    return;
  }
}

state ocaml_string extends Highlight
{
  /\\\\./ {
    language_print ($0);
  }
  /\"/ {
    language_print ($0);
    return;
  }
}


/*
Local variables:
mode: c
End:
*/
