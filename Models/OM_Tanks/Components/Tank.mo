within Tanks.Components;

model Tank
  import Modelica.Constants.pi;
  import SI = Modelica.SIunits;
  // Tank properties
  Modelica.Blocks.Interfaces.RealOutput level annotation(Placement(transformation(extent = {{100, -10}, {120, 10}})));
  // Tank geometry
  parameter SI.Area area = 1.0 "Area of tank";
  parameter Real gravity = 9.81;
  parameter Real level_start = 0.0;
  Interfaces.FluidPort_a port_a annotation(Placement(transformation(extent = {{-10, 90}, {10, 110}})));
  Interfaces.FluidPort_b port_b annotation(Placement(transformation(extent = {{-10, -110}, {10, -90}})));
equation
  // Mass balance equation
  der(level) = (port_a.lflow - port_b.lflow) / area;
  port_b.lflow = 0.5 * delay(port_a.lflow, 0.01);
  annotation(defaultComponentName = "tank", Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, initialScale = 0.2), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.VerticalCylinder), Rectangle(extent = DynamicSelect({{-100, -100}, {100, 10}}, {{-100, -100}, {100, (-100) + 200 * level / height}}), lineColor = {0, 0, 0}, fillColor = {85, 170, 255}, fillPattern = FillPattern.VerticalCylinder), Line(points = {{-100, 100}, {-100, -100}, {100, -100}, {100, 100}}, color = {0, 0, 0}), Text(extent = {{-95, 60}, {95, 40}}, lineColor = {0, 0, 0}, textString = "level ="), Text(extent = {{-95, -24}, {95, -44}}, lineColor = {0, 0, 0}, textString = DynamicSelect("%level_start", String(level_start, minimumLength = 1, significantDigits = 2)))}));
end Tank;