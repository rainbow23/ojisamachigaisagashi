//
// AdLantis Plugin
// AdViewTest
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

public class AdViewTest : AdView {
  
/*  void Start() {
    _log("AdViewTest.Start");
  }
*/
  
  void OnGUI() {
    resetButton();

    if(makeButton("Show")) {
      AdViewNative.Show();
    }

    if(makeButton("Hide")) {
      AdViewNative.Hide();
    }

    if(makeButton("Fade In")) {
      AdViewNative.FadeIn();
    }

    if(makeButton("Fade Out")) {
      AdViewNative.FadeOut();
    }

    if (makeButton("Top")) {
      AdViewNative.SetPosition(AdViewNative.Position.Top);
    }

    if (makeButton("Bottom")) {
      AdViewNative.SetPosition(AdViewNative.Position.Bottom);
    }

    if (makeButton("Left")) {
      AdViewNative.SetPosition(AdViewNative.Position.Left);
    }

    if (makeButton("Right")) {
      AdViewNative.SetPosition(AdViewNative.Position.Right);
    }

  }

  // code adapted from GREE SDK
  int buttonX = 0;
  int buttonY = 0;
  
  static int adMaxHeight = 50;
  
  void resetButton(){
    buttonX = 0;
    buttonY = 0;
  }
  
  int buttonColumns(){
    return 3;
  }
  
  int buttonWidth(){
    return (Screen.width - buttonOffsetX() * 2) /  buttonColumns() - buttonGapWidth();
  }
  
  int buttonHeight(){
    return 60;
  }
  
  int buttonGapWidth(){
    return 5;
  }
  
  int buttonGapHeight(){
    return 5;
  }
  
  int buttonOffsetX() {
    if (Screen.width > 320) {
      return (adMaxHeight * 2) + 5;
    }
    else {
      return adMaxHeight + 5;
    }
  }
  
  int buttonOffsetY() {
    return 70;
  }
  
  Rect buttonRect(int _buttonX, int _buttonY) {
    return new Rect(buttonOffsetX() + _buttonX * (buttonWidth() + buttonGapWidth()),
      buttonOffsetY() + _buttonY * (buttonHeight() + buttonGapHeight()),
      buttonWidth(), buttonHeight());
  }
  
  bool makeButton(string label){
    
    bool b = GUI.Button(buttonRect(buttonX, buttonY), label);
    
    buttonX++;
    if(buttonX == buttonColumns()){
      buttonX = 0;
      buttonY++;
    }
    
    if(b){
      _log(label+": tapped.");
    }
    
    return b;
  }
}
