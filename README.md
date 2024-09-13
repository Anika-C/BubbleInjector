# Bubble Injector

The Bubble Injector is a DIY scientific instrument designed to measure the fracture toughness (K<sub>Ic</sub>) of cohesive sediments using a bubble injection method. The system induces fracture in sediment samples by incrementally injecting air through a needle. The rising air pressure is monitored until it drops abruptly, indicating bubble formation. Fracture toughness is then calculated from the peak pressure at which fracture occurred. The system allows for measuring a depth profile with small-scale resolution and has produced measurements that compare well to past data.

This GitHub repository is meant to accompany the article: 
  Cho, Anika S., Dorgan, Kelly M., Lockridge, Grant. “Small-scale measurement of fracture toughness of muddy marine sediments via bubble injection.” Limnol-
  ogy and Oceanography: Methods, vol. 22, no. 8, 18 May 2024, pp. 527–535,
  https://doi.org/10.1002/lom3.10625

## Hardware
  + Syringe Pump:
    + NEMA Stepper Motor
    + 3mL Syringe
    + 80/20 Linear Motion Bearing/Frame
    + Custom aluminum parts (CAD files available)
  + Electronics:
    + Arduino Zero + SD Card Shield
    + TinyG CNC Controller (v8)
    + 4-20mA Pressure Sensor (0-15 PSI)
    
Assembly details, full parts list, and cost estimate available in repo.

G-code & Setup Reference: https://github.com/synthetos/TinyG/wiki/Homing-and-Limits-Description-and-Operation

TinyG CNC Stepper Motor Controller configuration details: **TinyG_Config_Settings.txt**

## Code
**Bubble_Injection_Aug2022.ino**: Initiates automatic air injection procedures based on serial input, logs pressure sensor data to an SD card

**processBubble.m**: Plots pressure data, identifies critical peak pressure, and calculates (K<sub>Ic</sub>)

