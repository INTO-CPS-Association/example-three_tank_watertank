# case-study_three_tank

## Example Description

The three-tank water tank model is an augmentation of a standard 20-sim example, and is developed to explore the impact on accuracy of multi-modelling across multiple CT models. The example comprises three water tanks which are filled and emptied. The first tank is filled from a source with a valve which may be turned on and off. The outflow of the first tank constitutes the inflow of the second, and so forth. A controller monitors the level of the third tank and controls a valve to a drain. 

A key feature of this example is the close coupling required between water tank 1 and 2, and the loose coupling to water tank 3. Water tanks 1 and 2 are tall and thin and are connected by a pipe at the bottom of the tanks, and therefore changes to the level of water tank 1 (due to water entering from the source) will quickly affect the level in water tank 2. This effect is not as prevalent between water tank 2 and 3. 


## INTO-CPS Technology

### INTO-CPS SysML profile

A SysML model produced using the INTO-CPS profile comprises two diagrams and focusses on the structure of the water tank model for multi-modelling; an Architecture Structure Diagram and a Connections Diagram. 

The Architecture Structure Diagram (ASD) shows the system composition in terms of component subsystems from the perspective of multi-modelling. This architecture differes from a holistic architecture due to the grouping of tanks into the different subsystems. 

In this Water Tank system model, the water tanks are split between two subsystems: *WaterTanks1* subsystem contains the *Source*, two *Water Tank* and   *Pipe* components; *WaterTanks2* subsystem comprises a single *Water Tank* and *Drain* components; a final cyber component *Controller* contains no other components. 

The two water tank subsystems are defined as continuous time models, both with 20-sim as the target platform. The controller component is a VDM-RT discrete event model. 

The Connections Diagram (CD) defines connections as follows: at the subsystem-level,  the output of water from the *WaterTanks1* subsystem is input to the *WaterTanks2* subsystem. This subsystem has two connections with the *Controller* cyber component - regarding the level and valve control.


### Models
The multi model, corresponding to the SysML model above, comprising 2 20-sim subsystems and a VDM subsystem.

The partitioning of the 20-sim model is straightforward, with a single signal between the two 20-sim subsystems representing the flow of water between tanks 2 and 3. The rationale behind this split is that the flow rate between tank 1 and 2 has a high frequency and amplitude, suggesting that splitting the two tanks would result in erroneous results when time steps are imposed in co-simulation. 

The VDM-RT controller model is a simple controller, which governs *Tank3*. The VDM-RT model contains a *System* class containing *HardwareInterface*  and *Controller* objects -- *hwi*  and *controller*, respectively. The *hwi* object includes the input and output variables of the model and design parameters. The *controller* object is supplied with an instance of the *LevelSensor*  (*sensor*) and *ValveActuator* (*valve*) classes -- each given access to different parts of the *hwi* object. The *sensor}object represents the sensor that measures the current water level, and *valve* is  represents the valve at the bottom of the tank.

The control loop retrieves the current level of water from the sensor and determines whether to set the valve to be open or closed depending on the level compared to some set maximum or minimum value. 


### Multi-model

There are three connections in the multi-model; firstly between the **flow** port of *WaterTanks1* to the **inFlow** of *WaterTanks2*; secondly between **valveControl** port of the *WaterTanks2* model to the **wt3_valve** of the *Controller*; and finally from the **wt3_level** of the *Controller* to the **level** port of *WaterTanks2*. 

In addition, there are two design parameters - **wt3\_min** and **wt3\_max**, both of type **real**.


### Co-simulation

Using the INTO-CPS Co-simulation Engine (COE), we may simulate the three FMU multi-CT model. We are able to log the water level of tank 3 and the flow rate between tank 2 and 3, using a fixed step size of  *0.00001*.


The results in the graph correspond closely to those of the baseline Crescendo model. During simulation, the water level raised to the maximum value (2.0 meters) and at 16.3 seconds the tank 3 valve is opened by the VDM-RT controller and the level drops to just below the minimum (1.0 meters) and at 16.9 seconds the valve is closed and the water level begins to rise again.

#### 3D Visualisation

To enable visualisation of the Three-tank model, a second Connection Diagram is defined in the SysML model using the *Visualisation* block type and setting the connector type to *Visualisation* as appropriate. In addition, the ASD is amended to include *Visualisation* block - *Visual*. 

To allow the visualisation FMU to depict the internal workings of the system's components, additional ports have been defined for the *WaterTanks1* and  *WaterTanks2* blocks. The *WaterTanks1* component exposes: **Tank1InFlow** -- corresponding to the rate of water flowing into *Tank1*; **Tank1WaterLevel* -- the water level of *Tank1*; and **Tank2WaterLevel** -- the water level of *Tank2*. The *WaterTanks2* component exposes the additional ports: **Tank3OutFlow** -- corresponding to the rate of water flowing out of *Tank3* and **puddle** -- the current volume of water in the drain (or puddle).


The corresponding configuration file is given below:
{
	"fmus":{
		"{c}":"../ThreeTank/3D/WaterTankController.fmu",
		"{t1}":"../ThreeTank/3D/WaterTanks1.fmu",
		"{t2}":"../ThreeTank/3D/WaterTanks2.fmu",
		"{3D}":"../ThreeTank/3D/3DAnimationFMU.fmu"
	},
	"connections":{
		"{c}.controller.wt3_valve":["{t2}.tanks2.valveControl", "{3D}.3DFMU.animation.tank3.valve.control"],
		"{t1}.tanks1.Tank2OutFlow":["{t2}.tanks2.inFlow", "{3D}.3DFMU.animation.tank2.outflow"],
		"{t2}.tanks2.level":["{c}.controller.wt3_level", "{3D}.3DFMU.animation.tank3.waterlevel"],
		"{t1}.tanks1.Tank1InFlow":["{3D}.3DFMU.animation.tank1.inflow"],
		"{t1}.tanks1.Tank1WaterLevel":["{3D}.3DFMU.animation.tank1.waterlevel"],
		"{t1}.tanks1.Tank2WaterLevel":["{3D}.3DFMU.animation.tank2.waterlevel"],
		"{t2}.tanks2.Tank3OutFlow":["{3D}.3DFMU.animation.tank3.outflow"],
		"{t2}.tanks2.puddle":["{3D}.3DFMU.animation.drain.puddle"]
	},
	"parameters":{
		"{c}.controller.wt3_max":2,
		"{c}.controller.wt3_min":1
	},
	"algorithm":{
		"type":"fixed-step",
		"size":0.01
	}
}




### Analyses and Experiments

#### Change parameter of sim (time and water levels)

#### Design Space Exploration

#### Cycles and dependancies (see D2.?a)