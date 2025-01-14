### Pilotcase Amilu

Amilu is a family-owned company with a vision to develop a small, real-time GPS tracker that leverages either LoRa (Long Range) or NB-IoT (Narrowband IoT) technologies. 
This device needs to be as small as possible, and aims to integrate seamlessly into an ecosystem of other security-related devices, providing enhanced tracking and location services. 
Due to confidentiality agreements and the sensitive nature of the project, further details remain undisclosed.

### Building a Real-Time GPS Tracker with NB-IoT

Creating a real-time GPS tracker with NB-IoT and an accelerometer, as compact as a coin, requires specialized equipment. Initially, we need to develop a prototype using development boards.

The main requirements for the device are:
* Wireless charging via a docking station
* Activation upon being lifted from the docking station (utilizing the accelerometer)
* Transmission of GPS coordinates every 10 to 60 seconds
* Battery life exceeding 12 hours

#### What is a GPS Tracker and what is NB-IoT?

1. **GPS Tracker**: This is an electronic device that uses the Global Positioning System (GPS) to determine and continuously report its precise location. By triangulating signals from at least four satellites, the device can calculate its position in terms of latitude and longitude. The GPS data is used for various purposes, such as navigation, asset tracking, or personal safety.

2. **NB-IoT (Narrowband IoT)**: NB-IoT is a low-power Wide Area Network (LPWAN) technology that facilitates communication between devices and the internet, especially for applications that transmit small amounts of data infrequently. It is designed to provide coverage over long distances and through physical obstructions, using minimal power.

3. **Accelerometer**: An accelerometer is a device that measures acceleration forces. In GPS trackers, it is used to detect movement and stillness, which can contribute to energy efficiency by only activating GPS and data transmission when movement is detected.

#### Key Steps to Build a Small GPS Tracker

1. **Component Selection**:
   - **GPS Module**: This component is responsible for obtaining positional data. Modern GPS modules can be very compact and offer high precision.
   - **NB-IoT Module**: Choose a module that best fits the coverage and power requirements of your application.
   - **Microcontroller Unit (MCU)**: This acts as the brain of the device, responsible for processing data from the GPS module, handling communication with the NB-IoT module, and processing signals from the accelerometer.
   - **Accelerometer**: This component adds motion detection, which can be used to control when the device should enter low-power mode or activate GPS tracking.
   - **Battery**: Choose a battery that can provide sufficient power for the expected lifetime of the device, often aiming to operate for months or even years on a single charge.

2. **Miniaturization Techniques**:
   - Use System-in-Package (SiP) or System-on-Chip (SoC) solutions where possible to integrate multiple components on a single chip.
   - Design custom PCBs that efficiently organize components to minimize the device's overall size.

3. **Power Management**:
   - Develop a power profile that optimizes when the device is fully active versus in low-power mode. The device should spend the majority of its time in its lowest power state, only activating upon motion signals detected by the accelerometer.
   - Implement efficient power-saving algorithms and components such as low-dropout regulators and efficient battery management systems.

#### Proving and Testing the Solution

1. **Prototype Development**:
   - Start by assembling a prototype using larger, commercially available development boards such as Arduino or Raspberry Pi, along with modules and sensors.
   - Focus on implementing the software stack to manage data from the GPS, NB-IoT, and accelerometer.

2. **Functional Testing**:
   - Perform tests to verify that the device successfully retrieves GPS data and transmits it without errors, and correctly detects and responds to motion using the accelerometer.
   - Ensure that the device operates effectively in various environments to simulate real-world conditions.

3. **Power Consumption Testing**:
   - Conduct tests to measure how much power is used, particularly during motion detection and data transmission. Use this data to further refine power management algorithms.

4. **Design Refinement**:
   - Once the prototype functions as expected, work on refining the design to shrink the components to the smallest possible form. This involves creating custom PCBs and using smaller, surface-mounted components.

5. **Real-World Deployment and Iteration**:
   - After initial testing, deploy the device in real-world scenarios to gather data and verify its reliability and performance over time.
   - Use feedback and data from deployment to continuously improve the device, focusing on durability, battery life, and connectivity.

It's important to note that in our IoT lab, we are currently only able to develop prototypes using development boards. This means we do not have the capability to produce miniaturized versions using technologies such as SiP and SoC. 
Instead, we focus on proving the concept and demonstrating functionality before the client potentially taking the next steps with external partners for miniaturization.

Building such a device involves interdisciplinary skills, combining aspects of electrical and computer engineering. Although challenging, developing a small, efficient, and reliable GPS tracker can have many applications in the tracking and IoT industries.
