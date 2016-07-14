function [DB] = privacy(k,eps, file, column1, column2)

debug_on_warning(1);
debug_on_error(1);

  PT = input(column1, column2, file);
  [C,A] = MDAV(PT,k);
  #draw_Clusters(Clusters);
  DB= diff_Private(C,A,k,eps);
endfunction