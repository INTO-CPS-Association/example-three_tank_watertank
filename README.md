# case-study_three_tank

## Example Description

The three-tank water tank model is an augmentation of a standard 20-sim example, and is developed to explore the impact on accuracy of multi-modelling across multiple CT models. The example comprises three water tanks which are filled and emptied. The first tank is filled from a source with a valve which may be turned on and off. The outflow of the first tank constitutes the inflow of the second, and so forth. A controller monitors the level of the third tank and controls a valve to a drain. 

![Overview of the three-tank water tank example](resources/ttwt_overview.png?raw=true "TTWT")


A key feature of this example is the close coupling required between water tank 1 and 2, and the loose coupling to water tank 3. Water tanks 1 and 2 are tall and thin and are connected by a pipe at the bottom of the tanks, and therefore changes to the level of water tank 1 (due to water entering from the source) will quickly affect the level in water tank 2. This effect is not as prevalent between water tank 2 and 3. 


## INTO-CPS Technology

### INTO-CPS SysML profile

A SysML model produced using the INTO-CPS profile comprises two diagrams and focusses on the structure of the water tank model for multi-modelling; an Architecture Structure Diagram and a Connections Diagram. 

The Architecture Structure Diagram (ASD) shows the system composition in terms of component subsystems from the perspective of multi-modelling. This architecture differs from a holistic architecture due to the grouping of tanks into the different subsystems. 

![Architecture Structure Diagram](resources/ttwt_asd_vis.png?raw=true "Architecture Structure Diagram")


In this Water Tank system model, the water tanks are split between two subsystems: *WaterTanks1* subsystem contains the *Source*, two *Water Tank* and   *Pipe* components; *WaterTanks2* subsystem comprises a single *Water Tank* and *Drain* components;  a cyber component \emph{Controller} contains no other components; and the 3D component is available for visualising the behaviour of the system. 

To allow the visualisation FMU to depict the internal workings of the system's components, additional ports have been defined for the *WaterTanks1* and  *WaterTanks2* blocks. The *WaterTanks1* component exposes: **Tank1InFlow** -- corresponding to the rate of water flowing into *Tank1*; **Tank1WaterLevel** -- the water level of *Tank1*; and **Tank2WaterLevel** -- the water level of *Tank2*. The *WaterTanks2* component exposes the additional ports: **Tank3OutFlow** -- corresponding to the rate of water flowing out of *Tank3* and **puddle** -- the current volume of water in the drain (or puddle).

The two water tank subsystems are defined as continuous time models, both with 20-sim as the target platform. The controller component is a VDM-RT discrete event model. 

Two System Block Instances are defined in the model to represent alternative system configurations -- they are defined in separate Connections Diagrams (CDs). The first CD defines connections as follows: at the subsystem-level,  the output of water from the *WaterTanks1* subsystem is input to the *WaterTanks2* subsystem. This subsystem has two connections with the *Controller* cyber component - regarding the level and valve control.


![Connections Diagram](resources/ttwt_cd.png?raw=true "Connections Diagram")

The second CD has several connectors between the system component instances and the 3D visualisation block instance. The connections in Figure~\ref{fig:threetankcd} are still present, with additional connections sending state information relating to tank water levels, flow rates and controller behaviour to the 3D model.

![Connections Diagram](resources/ttwt_cd_vis.png?raw=true "Connections Diagram")

### Models

Given the ASD of the SysML model, three (simulation) models are defined; 2 20-sim subsystems and a VDM subsystem.

The partitioning of the 20-sim model is straightforward, with a single signal between the two 20-sim subsystems representing the flow of water between tanks 2 and 3. The rationale behind this split is that the flow rate between tank 1 and 2 has a high frequency and amplitude, suggesting that splitting the two tanks would result in erroneous results when time steps are imposed in co-simulation. 

![20-sim subsystems](resources/ttwt_20sim_fmus.png?raw=true "Subsystems")
![WaterTanks1](resources/ttwt_20sim_wt1fmu.png?raw=true "WT1")
![WaterTanks2](resources/ttwt_20sim_wt2fmu.png?raw=true "WT2")

The VDM-RT controller model is a simple controller, which governs *Tank3*. The VDM-RT model contains a *System* class containing *HardwareInterface*  and *Controller* objects -- *hwi*  and *controller*, respectively. The *hwi* object includes the input and output variables of the model and design parameters. The *controller* object is supplied with an instance of the *LevelSensor*  (*sensor*) and *ValveActuator* (*valve*) classes -- each given access to different parts of the *hwi* object. The *sensor}object represents the sensor that measures the current water level, and *valve* is  represents the valve at the bottom of the tank.

The control loop retrieves the current level of water from the sensor and determines whether to set the valve to be open or closed depending on the level compared to some set maximum or minimum value. 


### Multi-model

Two multi-models are defined for the Three Tank Study corresponding to the two System block instances defined in the CDs of the SysML model. 

In the first multi-model (**Non-3D**), there are three FMUs and three connections. The FMUs comprise: WaterTankController, threewatertank1 and threewatertank2 -- exported from the VDM-RT and 20-sim models described above. The connections are as follows:  firstly between the **flow** port of *WaterTanks1* to the **inFlow** of *WaterTanks2*; secondly between **valveControl** port of the *WaterTanks2* model to the **wt3_valve** of the *Controller*; and finally from the **wt3_level** of the *Controller* to the **level** port of *WaterTanks2*. 

In addition, there are two design parameters - **wt3\_min** and **wt3\_max**, both of type **real**.

The second multi-model (**3D**) uses the 3D visualisation FMU, and has additional connections to that FMU.

### Co-simulation

Using the INTO-CPS Co-simulation Engine (COE), we may simulate the three FMU multi-CT model. We are able to log the water level of tank 3 and the flow rate between tank 2 and 3, using a fixed step size of  *0.00001*.

![Simulation results using the INTO-CPS COE](resources/ttwt_coe_res.png?raw=true "Results")

The results in the graph correspond closely to those of the baseline Crescendo model. During simulation, the water level raised to the maximum value (2.0 meters) and at 16.3 seconds the tank 3 valve is opened by the VDM-RT controller and the level drops to just below the minimum (1.0 meters) and at 16.9 seconds the valve is closed and the water level begins to rise again.

Co-simulating the 3D multi-model opens a 3D visualisation window which depicts the state of the Three-tank system as the simulation progresses. 


### Analyses and Experiments

#### Change parameter of sim (time and water levels)

#### Design Space Exploration

#### Cycles and dependancies (see D2.?a)