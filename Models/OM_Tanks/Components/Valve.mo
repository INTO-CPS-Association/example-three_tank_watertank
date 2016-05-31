within Tanks.Components;

model Valve
  parameter Real resistance = 7;
  // 10 % leakage
  Interfaces.FluidPort_a port_a annotation(Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
  Interfaces.FluidPort_b port_b annotation(Placement(transformation(extent = {{90, -10}, {110, 10}})));
  Modelica.Blocks.Interfaces.RealInput valveControl(min = 0, max = 1) "=1: completely open, =0: completely closed" annotation(Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = -90, origin = {0, 100}), iconTransformation(extent = {{-20, -20}, {20, 20}}, rotation = -90, origin = {0, 80})));
equation
  port_b.lflow = valveControl * port_a.lflow;
  annotation(Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{0, 50}, {0, 0}}, color = {0, 0, 0}), Rectangle(extent = {{-20, 60}, {20, 50}}, lineColor = {0, 0, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-100, 50}, {100, -50}, {100, 50}, {0, 0}, {-100, -50}, {-100, 50}}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Polygon(points = DynamicSelect({{-100, 0}, {100, -0}, {100, 0}, {0, 0}, {-100, -0}, {-100, 0}}, {{-100, 50 * opening_actual}, {-100, 50 * opening_actual}, {100, -50 * opening_actual}, {100, 50 * opening_actual}, {0, 0}, {-100, -50 * opening_actual}, {-100, 50 * opening_actual}}), fillColor = {0, 255, 0}, lineColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Polygon(points = {{-100, 50}, {100, -50}, {100, 50}, {0, 0}, {-100, -50}, {-100, 50}}, lineColor = {0, 0, 0})}), Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics));
end Valve;