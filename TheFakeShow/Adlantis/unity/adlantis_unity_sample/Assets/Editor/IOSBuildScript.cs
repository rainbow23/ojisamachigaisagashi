using UnityEngine;
//using System.Collections;
using UnityEditor;

public class IOSBuildScript : EditorWindow {
	
#if UNITY_IPHONE
	
	[MenuItem("Tools/IOSBuildScript")]
	
	static void PerformBuild()
	{
		System.Console.WriteLine("IOSBuildScript:PerformBuild");
		
		string[] scenes = {"Assets/Scenes/title.unity", "Assets/Scenes/Cube.unity"};
		
		BuildPipeline.BuildPlayer(scenes, "ios_project", BuildTarget.iPhone, BuildOptions.None);
		//BuildPipeline.BuildPlayer(scenes, "test_web_build", BuildTarget.WebPlayer, BuildOptions.None);

		System.Console.WriteLine("IOSBuildScript:PerformBuild - Finished!");
	}
	
#endif
}
