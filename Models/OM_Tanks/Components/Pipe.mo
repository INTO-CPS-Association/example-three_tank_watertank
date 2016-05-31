within Tanks.Components;

model Pipe
  import Modelica.Constants.pi;
  import SI = Modelica.SIunits;
  // Pipe geometry
  parameter SI.Area area = 1.0 "Area of pipe";
  parameter Real gravity = 9.81;
  parameter Real liquid_density = 1.0;
  Interfaces.FluidPort_a port_a annotation(Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Interfaces.FluidPort_b port_b annotation(Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  // Mass balance equation
  port_b.lflow = 0.8 * delay(port_a.lflow, 0.01);
  annotation(defaultComponentName = "pipe", Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-100, 40}, {100, -40}}, fillPattern = FillPattern.Solid, fillColor = {95, 95, 95}, pattern = LinePattern.None), Rectangle(extent = {{-100, 44}, {100, -44}}, lineColor = {0, 0, 0}, fillPattern = FillPattern.HorizontalCylinder, fillColor = {0, 127, 255})}));
end Pipe;