module demux1to4 (
    input  wire D,
    input  wire S1,
    input  wire S0,
    output wire Y0,
    output wire Y1,
    output wire Y2,
    output wire Y3
);
  wire nS1, nS0;
  not (nS1, S1);
  not (nS0, S0);

  // Tang 1: chi tinh 1 lan cho moi to hop D&S1 / D&nS1
  // p = D & nS1  (dung chung cho Y0, Y1)
  // q = D & S1   (dung chung cho Y2, Y3)
  wire p_n, p;
  wire q_n, q;
  nand (p_n, D, nS1);
  not (p, p_n);
  nand (q_n, D, S1);
  not (q, q_n);

  // Tang 2: phan phoi p, q theo S0
  wire y0_n, y1_n, y2_n, y3_n;
  nand (y0_n, p, nS0);
  not (Y0, y0_n);
  nand (y1_n, p, S0);
  not (Y1, y1_n);
  nand (y2_n, q, nS0);
  not (Y2, y2_n);
  nand (y3_n, q, S0);
  not (Y3, y3_n);
endmodule
