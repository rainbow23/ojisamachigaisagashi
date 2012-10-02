//
// AdLantis Plugin
// AdViewNative
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
using System.Runtime.InteropServices;

public class AdViewNative
{
  public enum Position {
    Top,
    Bottom,
    Left,
    Right,
  };
  
  [DllImport("__Internal")]
  private static extern void _AdView_SetPublisherId(string id);
  public static void SetPublisherId(string id)
  {
    _AdView_SetPublisherId(id);
  }

  [DllImport("__Internal")]
  private static extern void _AdView_SetGapPublisherId(string id);
  public static void SetGapPublisherId(string id)
  {
    _AdView_SetGapPublisherId(id);
  }
  
  [DllImport("__Internal")]
  private static extern void _AdView_ShowHide(bool showHide);
  
  public static void ShowHide(bool showHide)
  {
    _AdView_ShowHide(showHide);
  }
  
  public static void Show()
  {
    _AdView_ShowHide(true);
  }
  
  public static void Hide()
  {
    _AdView_ShowHide(false);
  }
  
  [DllImport("__Internal")]
  private static extern void _AdView_FadeIn();
  public static void FadeIn()
  {
    _AdView_FadeIn();
  }

  [DllImport("__Internal")]
  private static extern void _AdView_FadeOut();
  public static void FadeOut()
  {
    _AdView_FadeOut();
  }
  
  [DllImport("__Internal")]
  private static extern void _AdView_SetPosition(AdViewNative.Position position);
  public static void SetPosition(AdViewNative.Position position)
  {
    _AdView_SetPosition(position);
  }
  
  [DllImport("__Internal")]
  private static extern void _AdView_Log(string s);
  public static void Log(string s)
  {
    _AdView_Log(s);
  }
}
