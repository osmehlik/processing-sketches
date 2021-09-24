//
// Percentage
//

double getPart(double percent, double whole) {
  return whole * 0.01 * percent;
}

double getPercent(double part, double whole) {
  return part / (whole * 0.01);
}

double mapValue(double inMin, double inCur, double inMax, double outMin, double outMax) {
  double inRangePart = inCur - inMin;
  double inRangeWhole = inMax - inMin;

  double inPercent = getPercent(inRangePart, inRangeWhole);
  
  double outRangeWhole = outMax - outMin;
  
  double outRangePart = getPart(inPercent, outRangeWhole);
  
  return outMin + outRangePart;
}

