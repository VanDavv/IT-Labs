using System;
using System.IO;

public class MainClass {
  public static int Main(string[] args) {
    if (Directory.Exists("output"))
      Directory.Delete("output", true);
    Directory.CreateDirectory("output");
    string[] files = Directory.GetFiles("images/", "*.jpg", SearchOption.AllDirectories);
    foreach (var file in files){
      FileInfo info = new FileInfo(file);
      string new_filename = String.Concat(info.CreationTime.ToString("yyyy-MM-dd-HH-mm-ss-"), info.Name);
      info.CopyTo(String.Concat("output/", new_filename), true);
    }
    return 0;
  }
}