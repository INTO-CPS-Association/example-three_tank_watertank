within Tanks.Interfaces;

model Real2Fluid
  FluidPort_b port_b annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput u annotation(Placement(visible = true, transformation(origin = {-104, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-94, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation
  port_b.lflow = u;
  annotation(Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})), Diagram(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = true, initialScale = 0.1, grid = {2, 2})));
end Real2Fluid;