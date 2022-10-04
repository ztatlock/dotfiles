/* Contributed by Steve Chamberlain */

/* Not that colorful, and easy to read style */
/* I like  msvc, except for a couple of things */
state style_modest
{
  BEGIN {

    call (style_msvc);

    if (color)
      {
        face_keyword           = make_face (bold_font, 0, 0);
        face_comment           = make_face (italic_font, 0, 1);
        face_comment[fg_color] = language_color("red");
        face_string[fg_color]  = language_color("forest green");
        face_type              = make_face (italic_font, 0,1);
        face_reference         = make_face (italic_font, 0,1);
      }

    return;
  }
}


/*
Local variables:
mode: c
End:
*/
