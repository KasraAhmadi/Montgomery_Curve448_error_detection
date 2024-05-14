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



