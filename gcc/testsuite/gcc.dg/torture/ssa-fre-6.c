/* { dg-do compile } */
/* { dg-require-effective-target int32 } */
/* { dg-skip-if "" { *-*-* } { "-O0" } { "" } } */
/* { dg-additional-options "-fgimple -fdump-tree-fre1" } */

typedef int v4si __attribute__((vector_size(16)));

int __GIMPLE (ssa,startwith("fre"))
foo ()
{
  int * p;
  int i;
  int x[4];
  __SIZETYPE__ _1;
  __SIZETYPE__ _2;
  int _7;

  __BB(2):
  i_3 = 0;
  _1 = (__SIZETYPE__) i_3;
  _2 = _1 * _Literal (__SIZETYPE__) 4;
  p_4 = _Literal (int *) &x + _2;
  __MEM <v4si> ((v4si *)p_4) = _Literal (v4si) {};
  _7 = x[0];
  return _7;
}

/* { dg-final { scan-tree-dump "return 0;" "fre1" } } */
