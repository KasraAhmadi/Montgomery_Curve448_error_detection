RTL code of Error detection capable Montgomery Ladder over curve 448 in "Efficient Error Detection Cryptographic Architectures Benchmarked on FPGAs for Montgomery Ladder".<br>
Module hierarchy is as follow: 
<ul>
 <li>Iterator.sv
 <ul style="list-style-type: lower-alpha; padding-bottom: 0;">
  <li style="margin-left:2em">Montgomery_step.sv
     <ul style="list-style-type: lower-alpha; padding-bottom: 0;">
  <li style="margin-left:2em">core.sv
  <ul style="list-style-type: lower-alpha; padding-bottom: 0;">
  <li style="margin-left:2em">adder.sv (Modular Addition)</li>
    <li style="margin-left:2em">speed_mult_red (Modular Multiplication)</li>
  </li>
 </ul>
  </li>
 </ul>
 </li>
</ul>
<li>Error_detection.sv</li>
</ul>
<img src="https://github.com/KasraAhmadi/Montgomery_Curve448_error_detection/blob/main/diagram/design.png">

## citation
Please cite our papar if you find our repo helpful.
```
@ARTICLE{10587011,
  author={Ahmadi, Kasra and Aghapour, Saeed and Kermani, Mehran Mozaffari and Azarderakhsh, Reza},
  journal={IEEE Transactions on Very Large Scale Integration (VLSI) Systems}, 
  title={Efficient Error Detection Cryptographic Architectures Benchmarked on FPGAs for Montgomery Ladder}, 
  year={2024},
  volume={},
  number={},
  pages={1-0},
  keywords={Binary trees;Field programmable gate arrays;Elliptic curves;Hardware;Cryptography;Clocks;Software;ARM processor;fault detection;field-programmable gate array (FPGA);Montgomery Ladder;reliability},
  doi={10.1109/TVLSI.2024.3419700}}

```

