//
// AdLantis Sample
// Title
//
// Copyright 2011 Atlantis, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

using UnityEngine;
using System.Collections;

public class Title : MonoBehaviour {

  public GUISkin customSkin;

  public Texture2D phonePortraitBackground;
  public Texture2D tabletPortraitBackground;
  public Texture2D tabletLandscapeBackground;
  
  // Use this for initialization
/*  void Start () {
    
    }
*/  

  bool IsIPad() {
    #if UNITY_IPHONE
    
    return iPhoneSettings.generation == iPhoneGeneration.iPad1Gen || iPhoneSettings.generation == iPhoneGeneration.iPad2Gen;
    
    #else
    
    return false;
    
    #endif
  } 

  Texture2D BackgroundTexture() {
    // a better implementation of this method would determine the appropriate background by aspect ratio
    if (IsIPad()) {
      if (Screen.orientation == ScreenOrientation.LandscapeLeft || Screen.orientation == ScreenOrientation.LandscapeRight) {
        return tabletLandscapeBackground;
      }
      else {
        return tabletPortraitBackground;
      }
    }
    
    return phonePortraitBackground;
  }
  
  void DrawBackground() {
    GUI.DrawTexture(new Rect(0, 0, Screen.width, Screen.height), BackgroundTexture());  
  }
  
  void DisplayNextSceneButton() {
    GUI.skin = customSkin;
    
    int buttonWidth = 400;
    int buttonHeight = 100;
    
    if (GUI.Button(new Rect(Screen.width / 2 - buttonWidth / 2, Screen.height / 2, buttonWidth, buttonHeight), "Cube Test")) {
        Application.LoadLevel("Cube");
    }
  }
  
  void OnGUI () {
    DrawBackground();
    
    DisplayNextSceneButton();
  }
}
