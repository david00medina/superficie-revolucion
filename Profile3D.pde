import java.util.List;
import java.util.ArrayList;

public class Profile3D {
  private List<PVector> vertices;
  private PShape profile;
  private int weight;
  private int[] colorProfile;
  
  public Profile3D(int weight, int[] colorProfile) {
    vertices = new ArrayList<PVector>();
    this.weight = weight;
    this.colorProfile = colorProfile;
  }
  
  public void addVertex(float x, float y, float z) {
    vertices.add(new PVector(x, y, z));
  }
  
  public List<PVector> getVertices() {
    return vertices;
  }
  
  public void refresh() {
    buildProfile();
    shape(profile);
  }
  
  public void destroy() {
    vertices.clear();
    profile = null;
  }
  
  private void buildProfile() {
    profile = createShape();
    
    if(vertices.size() < 2) profile.beginShape(POINTS);
    else if(vertices.size() < 3) profile.beginShape(LINES);
    else profile.beginShape();
    
    strokeWeight(8);
    stroke(255, 0, 0);
    
    profile.noFill();
    profile.stroke(colorProfile[0], colorProfile[1], colorProfile[2]);
    profile.strokeWeight(weight);
    
    for(PVector v: vertices) {
      profile.vertex(v.x, v.y, v.z);
      point(v.x, v.y, v.z);
    }
    
    if(vertices.size() > 0) {
      PVector v = vertices.get(0);
      profile.vertex(v.x, v.y, v.z);
    }
    
    profile.endShape();
  }
  
  public PShape getShape() {
    buildProfile();
    return profile;
  }
  
  public int[] getColor() {
    return colorProfile;
  }
  
  public int getWeight() {
    return weight;
  }
}
