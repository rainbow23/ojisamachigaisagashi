//
// AdLantis Plugin
// AdView
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

public class AdView : MonoBehaviour {
  
  void Start() {
    _log("AdView.Start");
    
    // 
    // 
    // 下記の行をコメントアウトして、管理画面へ表示されたSDK用の広告枠コードをコピーして下さい。
    // 
    // 
    //AdViewNative.SetPublisherId("");
  }
  
  public void _log(string s) {
    AdViewNative.Log(s);
  }
  
}
