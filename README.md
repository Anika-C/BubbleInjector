# Bubble Injector

The Bubble Injector is a DIY scientific instrument designed to measure the fracture toughness (K<sub>Ic</sub>) of cohesive sediments using a bubble injection method. The system induces fracture in sediment samples by incrementally injecting air through a needle. The rising air pressure is monitored until it drops abruptly, indicating bubble formation. Fracture toughness is then calculated from the peak pressure at which fracture occurred. The system allows for measuring a depth profile with small-scale resolution and has produced measurements that compare well to past data.

This GitHub repository is meant to accompany the article, _Bubbles & Burrows: Characterizing the Fracture Behavior of Marine Sediments Via Bubble Injection_.

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

## Code
**Bubble_Injection_Aug2022.ino**: Initiates automatic air injection procedures based on serial input, logs pressure sensor data to an SD card

**processBubble.m**: Plots pressure data, identifies critical peak pressure, and calculates (K<sub>Ic</sub>)
