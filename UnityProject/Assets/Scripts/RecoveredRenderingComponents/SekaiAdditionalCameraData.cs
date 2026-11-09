using UnityEngine;
namespace UnityEngine.Rendering.Universal {
public sealed class SekaiAdditionalCameraData : MonoBehaviour {
 void OnEnable() { var camera=GetComponent<Camera>(); if(camera) camera.GetUniversalAdditionalCameraData().SetRenderer(0); }
} }