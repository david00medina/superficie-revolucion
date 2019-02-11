import java.util.List;
import java.util.ArrayList;

public class LinearRotation3D {
  int longitude;
  int latitude;
  PVector[][] pointCloud;
  List<PShape> stripes;
  int weight;
  int[] color3DModel;
  int[] figureFill;
  
  public LinearRotation3D(int longitude, int weight, int[] color3DModel, int[] figureFill) {
    this.longitude = longitude;
    latitude = -1;
    this.weight = weight;
    this.color3DModel= color3DModel;
    this.figureFill = figureFill;
    stripes = new ArrayList<PShape>();
  }
  
  public void createSurface(Profile3D p) {
    createPointsCloud(p);
    build3DModel();
  }
  
  private void createPointsCloud(Profile3D p) {
    PShape shape = p.getShape();
    
    pointCloud = new PVector[longitude][latitude];
    
    for(int i = 0; i < longitude; i++) {
      float theta = i*2*PI/longitude;
      for(int j = 0; j < latitude; j++) {
        PVector vertex = shape.getVertex(j);
        float gamma = width/2;
        float x = (vertex.x - gamma)*cos(theta) - vertex.z*sin(theta) + gamma;
        float y = vertex.y;
        float z = (vertex.x - gamma)*sin(theta) + vertex.z*cos(theta);
        pointCloud[i][j] = new PVector(x, y, z);
      }
    }
  }
  
  private void build3DModel() {
    for(int i = 0; i <= longitude; i++) {
      
      PShape model3D = createShape();
      model3D.beginShape(TRIANGLE_STRIP);
      
      model3D.stroke(color3DModel[0], color3DModel[1], color3DModel[2]);
      model3D.strokeWeight(weight);
      model3D.fill(figureFill[0], figureFill[1], figureFill[2]);
      
      for(int j = 0; j <= latitude; j++) {
        PVector v1 = pointCloud[i%longitude][j%latitude];
        model3D.vertex(v1.x, v1.y, v1.z);
        PVector v2 = pointCloud[(i+1)%longitude][j%latitude];
        model3D.vertex(v2.x, v2.y, v2.z);
      }
      
      model3D.endShape();
      stripes.add(model3D);
    }
  }
  
  public void refresh() {
    PVector centroid = getCentroid();
    translate(mouseX-centroid.x, mouseY-centroid.y, 0);
    strokeWeight(10);
    for(int i = 0; i < longitude; i++) {
      for(int j = 0; j < latitude; j++) {
        PVector v = pointCloud[i][j];
        point(v.x, v.y, v.z);
      }
    }
    for(PShape stripe: stripes) {
      shape(stripe);
    }
  }
  
  public void destroy() {
    pointCloud = null;
    stripes.clear();
  }
  
  public void setLatitude(int latitude) {
    this.latitude = latitude;
  }
  
  public PVector getCentroid() {
    int xSum = 0, ySum = 0, zSum = 0;
    int numPoints = latitude*longitude;
    for(int i = 0; i < longitude; i++) {
      for(int j = 0; j < latitude; j++) {
        PVector v = pointCloud[i][j];
        xSum += v.x;
        ySum += v.y;
        zSum += v.z;
      }
    }
    return new PVector(xSum/numPoints, ySum/numPoints, zSum/numPoints);
  }
}
