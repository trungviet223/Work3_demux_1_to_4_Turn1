HUONG DAN CHINH SUA test/Makefile CO SAN TRONG TEMPLATE
========================================================

Template ttsky-verilog-template da co san file test/Makefile.
Ban CHI can tim dong khai bao PROJECT_SOURCES va them "demux1to4.v" vao,
vi day la file .v thu hai trong thu muc src/ ma project.v goi toi.

Truoc khi sua, dong do thuong co dang gan giong:

    PROJECT_SOURCES = project.v

Sua thanh:

    PROJECT_SOURCES = project.v demux1to4.v

Neu Makefile dang liet ke source theo kieu khac (vi du doc truc tiep
tu info.yaml qua bien SIM_BUILD/VERILOG_SOURCES), ban khong can dong
gi them o day, vi buoc build da tu dong doc source_files trong
info.yaml (xem file info.yaml.snippet.txt).

Sau khi sua xong, chay thu local (neu da cai cocotb + icarus verilog):

    cd test
    make

Ket qua mong doi: tat ca 2 test (test_demux1to4_exhaustive va
test_demux1to4_zero_when_d_low) deu PASS.
